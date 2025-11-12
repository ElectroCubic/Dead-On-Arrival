extends Control
class_name CaseLog

@onready var caselog_font := preload("res://resources/fonts/SpecialElite-Regular.ttf")
@onready var scroll_container = $Panel/ScrollContainer
@onready var vbox = $Panel/ScrollContainer/VBoxContainer

func _ready():
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("ToggleCaselog"):
		toggle_log()

func toggle_log():
	if not Globals.is_dialogue_playing:
		visible =  !visible

func add_entry(text: String):
	var label = Label.new()
	label.text = "- " + text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.add_theme_font_override("font", caselog_font)
	label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(label)
	
	# Add spacing after each entry
	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 15) 
	vbox.add_child(spacer)
