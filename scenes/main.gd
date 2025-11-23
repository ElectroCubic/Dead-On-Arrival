extends Node2D
class_name Main

@export var normal_btn_font_size1: int = 56
@export var expand_btn_font_size1: int = 78
@export var normal_btn_font_size2: int = 42
@export var expand_btn_font_size2: int = 56
@export_range(0.0,1.0,0.1) var move_time_sec: float = 0.1
var bg1 := preload("res://audio/suspense-detective-horror-160021.mp3")

func _ready() -> void:
	if AudioManager.bgm_player.stream != bg1:
		AudioManager.change_bgm(bg1)
		
	if not AudioManager.bgm_player.playing:
		AudioManager.bgm_player.play()
		AudioManager.fade_in_music()

func _on_play_btn_pressed():
	AudioManager.click_sfx.play()
	AudioManager.fade_out_music()
	await get_tree().create_timer(0.5).timeout
	TransitionLayer.change_scene("res://scenes/levels/intro.tscn")

func _on_options_btn_pressed():
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	$MainUI.hide()
	$OptionsMenuScreen.show()

func _on_quit_btn_pressed():
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_play_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()

func _on_options_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()

func _on_quit_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
