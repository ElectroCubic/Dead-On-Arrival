extends Area2D

@export var target_scene: String

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	if visible:
		return
	
	if Globals.investigation and not visible:
		visible = true

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not Globals.investigation or Globals.is_dialogue_playing:
		return
		
	if event is InputEventMouseButton and Input.is_action_just_pressed("LeftClick"):
		TransitionLayer.change_scene(target_scene)
