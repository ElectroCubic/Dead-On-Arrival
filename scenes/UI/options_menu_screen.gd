extends CanvasLayer

@onready var main = get_node("../") as Main
@onready var mainUI = get_node("../MainUI")
@onready var backBtn = $Back

func _on_music_slider_value_changed(value) -> void:
	AudioManager.current_music_vol = value
	AudioServer.set_bus_volume_db(AudioManager.music_bus_id,linear_to_db(value))
	AudioServer.set_bus_mute(AudioManager.music_bus_id, value < 0.05)
	AudioManager.rollover_sfx.play()

func _on_sfx_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(AudioManager.sfx_bus_id,linear_to_db(value))
	AudioServer.set_bus_mute(AudioManager.sfx_bus_id, value < 0.05)
	AudioManager.rollover_sfx.play()

func _on_back_pressed() -> void:
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	hide()
	mainUI.show()
	main.display_title_effect(main.title_text, 3.0)

func _on_back_mouse_entered() -> void:
	AudioManager.rollover_sfx.play()
	main.modify_btn_size(
		backBtn,
		main.normal_btn_font_size2,
		main.expand_btn_font_size2,
		main.move_time_sec
	)

func _on_back_mouse_exited() -> void:
	main.modify_btn_size(
		backBtn, 
		main.expand_btn_font_size2,
		main.normal_btn_font_size2,
		main.move_time_sec
	)
