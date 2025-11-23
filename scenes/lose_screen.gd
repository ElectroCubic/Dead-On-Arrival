extends Control

func _ready() -> void:
	AudioManager.fade_out_music()
	AudioManager.bgm_player.stop()
	AudioManager.lose_sound.play()

func _on_restart_pressed() -> void:
	AudioManager.click_sfx.play()
	Globals.star_level = 3
	Globals.clear_all()
	Globals.reset_items()
	TransitionLayer.change_scene("res://scenes/levels/study.tscn")

func _on_quit_btn_pressed() -> void:
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()

func _on_restart_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()

func _on_quit_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
