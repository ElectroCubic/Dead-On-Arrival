extends Control

func _on_restart_pressed() -> void:
	Globals.star_level = 3
	Globals.clear_all()
	TransitionLayer.change_scene("res://scenes/levels/study.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
