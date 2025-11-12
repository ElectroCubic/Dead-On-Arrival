@tool
extends Area2D
class_name Item

@onready var texture_rect: TextureRect = $TextureRect

@export var item_name: String = "Unknown Item"
@export var item_icon: Texture:
	set(value):
		item_icon = value
		if is_inside_tree() and texture_rect:
			texture_rect.texture = item_icon
@export var item_info: String = "Just a normal object."
@export var click_required: int = 1
@export var item_id: String = ""

signal item_collected(item_data)

var clicks: int = 0

func _ready():
	input_pickable = true
	texture_rect.texture = item_icon

	if item_id != "" and Globals.has_item_id(item_id):
		queue_free()
		return

func _input_event(_viewport, event, _shape_idx):
	if Globals.is_dialogue_playing:
		return
		
	if event is InputEventMouseButton and Input.is_action_just_pressed("LeftClick"):
		clicks += 1

		if clicks == click_required:
			var data = {
				"name": item_name,
				"icon": item_icon,
				"info": item_info
			}

			item_collected.emit(data)
			if item_id != "":
				Globals.mark_item_collected(item_id)

			queue_free()
