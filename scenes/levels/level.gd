extends Node2D
class_name Level

signal show_arrows

var game_over: bool = false
var question_id: String = ""
@onready var interrogation_data_e := preload("res://resources/EleanorInterrogation.tres")
@onready var interrogation_data_l := preload("res://resources/LillianInterrogation.tres")
@onready var case_log_ui := $CaseLogUI
@onready var inventory_ui := $InventoryUI
@onready var dialogue_box: DialogueBox = $DialogueBox
@onready var lillian_btn: Button = $InterrogateBtn/LillianBtn
@onready var eleanor_btn: Button = $InterrogateBtn/EleanorBtn
@onready var bg2 := preload("res://audio/stalking-my-next-victim-cinematic-true-crime-and-detective-music-198242.mp3")

func _ready() -> void:
	if AudioManager.bgm_player.stream != bg2:
		AudioManager.change_bgm(bg2)
	
	if not AudioManager.bgm_player.playing:
		AudioManager.bgm_player.play()
		AudioManager.fade_in_music()

	inventory_ui.connect("show_item", _on_show_item)
	dialogue_box.connect("dialogue_processed", on_dialogue_processed)
	dialogue_box.connect("dialogue_started", _on_dialogue_box_dialogue_started)
	dialogue_box.connect("dialogue_ended", _on_dialogue_box_dialogue_ended)
	dialogue_box.connect("dialogue_signal", _on_dialogue_signal_received)
	
	for item in $Items.get_children():
		item.connect("item_collected", _on_item_collected)
	
	if not Globals.investigation:
		$InterrogateBtn.hide()
		$StarLevel.hide()
		if not dialogue_box.is_running():
			dialogue_box.start()
	else:
		dialogue_box.stop()

func _process(_delta: float) -> void:
	check_ending()

func check_ending():
	if Globals.winConditionOne and Globals.winConditionTwo and not game_over:
		dialogue_box.data = interrogation_data_e
		dialogue_box.start_id = interrogation_data_e.starts.keys()[5]  # END
		if not dialogue_box.is_running():
			dialogue_box.start()

func _on_dialogue_signal_received(value: String):
	match value:
		"DinnerHall":
			TransitionLayer.change_scene("res://scenes/levels/dinner_hall.tscn")
		"Study":
			TransitionLayer.change_scene("res://scenes/levels/study.tscn")
		"Start_Investigation":
			Globals.investigation = true
			$InterrogateBtn.show()
			$StarLevel.show()
			show_arrows.emit()
		"ReduceStar":
			check_star_level(1)
		"GotClue1":
			Globals.winConditionOne = true
		"GotClue2":
			Globals.winConditionTwo = true
		"END":
			end_game()
		"ShowPapers", "ShowGloves", "ShowHankie":
			question_id = value
		_:
			pass

func end_game():
	game_over = true
	dialogue_box.stop()
	TransitionLayer.change_scene("res://scenes/end.tscn")

func check_star_level(amount: int):
	AudioManager.reduce_star.play(0.3)
	Globals.star_level -= amount
	if Globals.star_level <= 0:
		dialogue_box.stop()
		TransitionLayer.change_scene("res://scenes/lose_screen.tscn")

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
	AudioManager.click_sfx.play()
	toggle_option_btns()

func toggle_option_btns():
	lillian_btn.visible = !lillian_btn.visible
	eleanor_btn.visible = !eleanor_btn.visible

func check_evidence_is_correct(presented_item_name: String, correct_item_name: String, dialogue_data: DialogueData, correct_id_index: int, wrong_id_index: int):
	dialogue_box.data = dialogue_data
	if presented_item_name == correct_item_name:
		dialogue_box.start_id = dialogue_data.starts.keys()[correct_id_index]  # YES
		AudioManager.clue_found.play()
	else:
		dialogue_box.start_id = dialogue_data.starts.keys()[wrong_id_index]  # NO

func _on_show_item(item):
	dialogue_box.stop()
	var presented_item_name: String = item["name"]
	
	match question_id:
		"ShowHankie":
			check_evidence_is_correct(presented_item_name, "Handkerchief", interrogation_data_l, 2, 1)
		"ShowPapers":
			check_evidence_is_correct(presented_item_name, "Burnt Papers", interrogation_data_e, 4, 2)
		"ShowGloves":
			check_evidence_is_correct(presented_item_name, "Stained Gloves", interrogation_data_e, 3, 1)
		_:
			return

	if not dialogue_box.is_running():
		dialogue_box.start()

func _on_lillian_btn_pressed() -> void:
	AudioManager.click_sfx.play()
	start_interrogation(interrogation_data_l, interrogation_data_l.starts.keys()[0])

func _on_eleanor_btn_pressed() -> void:
	AudioManager.click_sfx.play()
	start_interrogation(interrogation_data_e, interrogation_data_e.starts.keys()[0])

func start_interrogation(dialogue_data: DialogueData, start_id: String):
	dialogue_box.data = dialogue_data
	dialogue_box.start_id = start_id
	if not dialogue_box.is_running():
		dialogue_box.start()
	else:
		dialogue_box.stop()
		
	toggle_option_btns()


func _on_lillian_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()

func _on_eleanor_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()


func _on_dialogue_box_option_selected(_idx: int) -> void:
	AudioManager.rollover_sfx.play()
