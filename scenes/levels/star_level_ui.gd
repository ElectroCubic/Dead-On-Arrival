extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var blank := preload("res://graphics/UI/Icons/Icon_Large_StarGrey.svg")


func _ready() -> void:
	Globals.connect("stat_change", update_stats)

func update_stats():
	var stars = h_box_container.get_children()
	
	if Globals.star_level == 2:
		stars[0].texture = blank
	elif Globals.star_level == 1:
		stars[0].texture = blank
		stars[1].texture = blank
	elif Globals.star_level == 0:
		stars[0].texture = blank
		stars[1].texture = blank
		stars[2].texture = blank
