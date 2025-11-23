extends Node2D
class_name Main

@onready var title_text: RichTextLabel = $MainUI/TitleText
@onready var credits_text: RichTextLabel = $CreditsScreen/CreditsTitle
@onready var play_btn: Button = $MainUI/PlayBtn
@onready var options_btn: Button = $MainUI/OptionsBtn
@onready var credits_btn: Button = $MainUI/CreditsBtn
@onready var quit_btn: Button = $MainUI/QuitBtn
@export var normal_btn_font_size2: int = 50
@export var expand_btn_font_size2: int = 60
@export_range(0.0,1.0,0.1) var move_time_sec: float = 0.1
var bg1 := preload("res://audio/suspense-detective-horror-160021.mp3")

func _ready() -> void:
	if AudioManager.bgm_player.stream != bg1:
		AudioManager.change_bgm(bg1)
		
	if not AudioManager.bgm_player.playing:
		AudioManager.bgm_player.play()
		AudioManager.fade_in_music()

	display_title_effect(title_text, 3.0)

func display_title_effect(text: RichTextLabel, time_sec: float):
	text.visible_ratio = 0.0
	var tween := create_tween()
	tween.tween_property(text, "visible_ratio", 1, time_sec)

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

func _on_credits_btn_pressed() -> void:
	display_title_effect(credits_text, 2.0)
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	$MainUI.hide()
	$CreditsScreen.show()

func _on_quit_btn_pressed():
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()

func change_btn_font_size(btn: Button, size: int) -> void:
	btn.add_theme_font_size_override("font_size",size)
	btn.queue_redraw()

func modify_btn_size(btn: Button, from_size: int, to_size: int, time_sec: float) -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_method(
		func(value): change_btn_font_size(btn, value),
		from_size, 
		to_size, 
		time_sec
	)

func _on_play_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
	modify_btn_size(
		play_btn,
		normal_btn_font_size2,
		expand_btn_font_size2,
		move_time_sec
	)

func _on_options_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
	modify_btn_size(
		options_btn,
		normal_btn_font_size2,
		expand_btn_font_size2,
		move_time_sec
	)

func _on_credits_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
	modify_btn_size(
		credits_btn,
		normal_btn_font_size2,
		expand_btn_font_size2,
		move_time_sec
	)

func _on_quit_btn_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
	modify_btn_size(
		quit_btn,
		normal_btn_font_size2,
		expand_btn_font_size2,
		move_time_sec
	)

func _on_play_btn_mouse_exited() -> void:
	modify_btn_size(
		play_btn,
		expand_btn_font_size2,
		normal_btn_font_size2,
		move_time_sec
	)

func _on_options_btn_mouse_exited() -> void:
	modify_btn_size(
		options_btn,
		expand_btn_font_size2,
		normal_btn_font_size2,
		move_time_sec
	)

func _on_credits_btn_mouse_exited() -> void:
	modify_btn_size(
		credits_btn,
		expand_btn_font_size2,
		normal_btn_font_size2,
		move_time_sec
	)

func _on_quit_btn_mouse_exited() -> void:
	modify_btn_size(
		quit_btn,
		expand_btn_font_size2,
		normal_btn_font_size2,
		move_time_sec
	)

func _on_itch_page_btn_pressed() -> void:
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	
	var url = "https://electrocubic.itch.io/"

	if OS.has_feature("web"):
		JavaScriptBridge.eval("window.open('%s', '_blank');" % url)
	else:
		OS.shell_open(url)
