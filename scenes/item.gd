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

signal item_collected(item_data)

func _ready():
	input_pickable = true  # allows click detection
	texture_rect.texture = item_icon

func _input_event(_viewport, event, _shape_idx):
	if Globals.is_dialogue_playing:
		return
		
	if event is InputEventMouseButton and Input.is_action_just_pressed("LeftClick"):
		var data = {
			"name": item_name,
			"icon": item_icon,
			"info": item_info
		}
		item_collected.emit(data)
		queue_free()  # remove item from world
