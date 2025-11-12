extends Node2D
class_name Level

signal show_arrows

@onready var interrogation_data := preload("res://LillianInterrogation.tres")
@onready var case_log_ui := $CaseLogUI
@onready var inventory_ui := $InventoryUI
@onready var dialogue_box: DialogueBox = $DialogueBox

func _ready() -> void:
	dialogue_box.connect("dialogue_processed", on_dialogue_processed)
	dialogue_box.connect("dialogue_started", _on_dialogue_box_dialogue_started)
	dialogue_box.connect("dialogue_ended", _on_dialogue_box_dialogue_ended)
	dialogue_box.connect("dialogue_signal", _on_dialogue_signal_received)
	
	for item in $Items.get_children():
		item.connect("item_collected", _on_item_collected)
	
	if not Globals.investigation:
		$InterrogateBtn.hide()
		if not dialogue_box.is_running():
			dialogue_box.start()
	else:
		dialogue_box.stop()

func _on_dialogue_signal_received(value: String):
	if value == "DinnerHall":
		TransitionLayer.change_scene("res://scenes/levels/dinner_hall.tscn")
	elif value == "Study":
		TransitionLayer.change_scene("res://scenes/levels/study.tscn")
	elif value == "Start_Investigation":
		Globals.investigation = true
		$InterrogateBtn.show()
		show_arrows.emit()
		
func on_dialogue_processed(speaker: Variant, dialogue: String, _options: Array[String]) -> void:
	var sprite_node = dialogue_box.get_child(1)
	sprite_node.texture = speaker.image
	var regex := RegEx.new()
	regex.compile(r"\[.*?\]")
	dialogue = regex.sub(dialogue, "", true).strip_edges()
	if speaker.name != "Detective":
		case_log_ui.add_entry(speaker.name + ": " + dialogue)

func _on_item_collected(item_data):
	inventory_ui.add_item(item_data)
	var text = "Clue found! " + item_data["name"] + ": " + item_data["info"]
	case_log_ui.add_entry(text)

func _on_dialogue_box_dialogue_started(_id: String) -> void:
	Globals.is_dialogue_playing = true

func _on_dialogue_box_dialogue_ended() -> void:
	Globals.is_dialogue_playing = false

func _on_interrogate_btn_pressed() -> void:
	dialogue_box.data = interrogation_data
	dialogue_box.start_id = interrogation_data.starts.keys()[0]
	if not dialogue_box.is_running():
		dialogue_box.start()
	else:
		dialogue_box.stop()
