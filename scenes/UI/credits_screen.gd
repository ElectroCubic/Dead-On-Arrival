extends CanvasLayer

@onready var main = get_node("../") as Main
@onready var mainUI = get_node("../MainUI")
@onready var back_btn: TextureButton = $BackBtn

func _on_back_btn_pressed() -> void:
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.5).timeout
	hide()
	mainUI.show()
	main.display_title_effect(main.title_text, 3.0)

func _on_back_btn_mouse_entered() -> void:
	back_btn.modulate = Color(1.0, 0.5, 0.5, 1.0)

func _on_back_btn_mouse_exited() -> void:
	back_btn.modulate = Color(1.0, 0.0, 0.0, 1.0)
