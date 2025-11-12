extends Node2D
class_name Level

@onready var case_log_ui := $CaseLogUI
@onready var inventory_ui := $InventoryUI
@onready var dialogue_box: DialogueBox = $DialogueBox
@onready var characters_list := preload("res://examples/Characters.tres").characters

var speaker_dict: Dictionary = {}

func _ready() -> void:
	dialogue_box.connect("dialogue_processed", on_dialogue_processed)
	dialogue_box.connect("dialogue_started", _on_dialogue_box_dialogue_started)
	dialogue_box.connect("dialogue_ended", _on_dialogue_box_dialogue_ended)
		
	for item in $Items.get_children():
		item.connect("item_collected", _on_item_collected)
		
	var i = 0
	for c in characters_list:
		speaker_dict[c.name] = i
		i += 1
	
	if not dialogue_box.is_running():
		dialogue_box.start()
	
func on_dialogue_processed(speaker: String, dialogue: String, _options: Array[String]) -> void:
	var sprite_node = dialogue_box.get_child(1)
	sprite_node.texture = characters_list[speaker_dict[speaker]].image
	var regex := RegEx.new()
	regex.compile(r"\[.*?\]")
	dialogue = regex.sub(dialogue, "", true).strip_edges()
	if speaker != "Detective":
		case_log_ui.add_entry(speaker + ": " + dialogue)

func _on_item_collected(item_data):
	inventory_ui.add_item(item_data)
	var text = "Clue found! " + item_data["name"] + ": " + item_data["info"]
	case_log_ui.add_entry(text)

func _on_dialogue_box_dialogue_started(_id: String) -> void:
	Globals.is_dialogue_playing = true

func _on_dialogue_box_dialogue_ended() -> void:
	Globals.is_dialogue_playing = false
