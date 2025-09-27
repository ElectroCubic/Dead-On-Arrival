extends Node2D
class_name Main

func _on_play_btn_pressed():
	TransitionLayer.change_scene("res://scenes/levels/level.tscn")

func _on_options_btn_pressed():
	print("Options")

func _on_quit_btn_pressed():
	get_tree().quit()
