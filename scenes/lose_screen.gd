extends Control

@export var normal_btn_font_size: int = 50
@export var expand_btn_font_size: int = 60
@export_range(0.0,1.0,0.1) var move_time_sec: float = 0.1
@onready var restart_btn: Button = $Restart
@onready var quit_btn: Button = $QuitBtn

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

func change_btn_font_size(btn: Button, btn_size: int) -> void:
	btn.add_theme_font_size_override("font_size",btn_size)
	btn.queue_redraw()

func modify_btn_size(btn: Button, from_size: int, to_size: int, time_sec: float) -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_method(
		func(value): change_btn_font_size(btn, value),
		from_size, 
		to_size, 
		time_sec
	)

func _on_restart_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
	modify_btn_size(
		restart_btn,
		normal_btn_font_size,
		expand_btn_font_size,
		move_time_sec
	)

func _on_quit_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
	modify_btn_size(
		quit_btn,
		normal_btn_font_size,
		expand_btn_font_size,
		move_time_sec
	)

func _on_restart_mouse_exited() -> void:
	modify_btn_size(
		restart_btn,
		expand_btn_font_size,
		normal_btn_font_size,
		move_time_sec
	)

func _on_quit_btn_mouse_exited() -> void:
	modify_btn_size(
		quit_btn,
		expand_btn_font_size,
		normal_btn_font_size,
		move_time_sec
	)
