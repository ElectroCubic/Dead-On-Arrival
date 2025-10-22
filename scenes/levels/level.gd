extends Node2D

@onready var dialogue_box: DialogueBox = $DialogueBox

func _ready() -> void:
	if not dialogue_box.is_running():
		dialogue_box.start()
