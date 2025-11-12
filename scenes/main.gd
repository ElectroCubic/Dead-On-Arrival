extends Node2D
class_name Main

@export var normal_btn_font_size1: int = 56
@export var expand_btn_font_size1: int = 78
@export var normal_btn_font_size2: int = 42
@export var expand_btn_font_size2: int = 56
@export_range(0.0,1.0,0.1) var move_time_sec: float = 0.1

func _on_play_btn_pressed():
	TransitionLayer.change_scene("res://scenes/levels/intro.tscn")

func _on_options_btn_pressed():
	$MainUI.hide()
	$OptionsMenuScreen.show()

func _on_quit_btn_pressed():
	get_tree().quit()
