extends Control
class_name Inventory

@onready var slots := $HBoxContainer.get_children()

var inventory_items: Array = []

func _ready():
	# Load previously saved data if any
	inventory_items = Globals.inventory_items.duplicate(true)
	_refresh_slots()
	
	for slot in slots:
		slot.connect("pressed", _on_slot_pressed.bind(slot))
		slot.disabled = true
		
	_refresh_slots()

func add_item(item_data):
	if inventory_items.size() < slots.size():
		inventory_items.append(item_data)
		Globals.add_item(item_data)
		_refresh_slots()
	else:
		print("Inventory full!")

func _refresh_slots():
	for i in range(slots.size()):
		if i < inventory_items.size():
			slots[i].get_child(-1).texture = inventory_items[i]["icon"]
			slots[i].disabled = false
			slots[i].tooltip_text = "%s\n%s" % [inventory_items[i]["name"], inventory_items[i]["info"]]
		else:
			slots[i].disabled = true

func _on_slot_pressed(slot):
	var index = slots.find(slot)
	if index >= 0 and index < Globals.inventory_items.size():
		var item = Globals.inventory_items[index]
		print("Selected:", item["name"], "-", item["info"])
		# TODO: Perform more actions later if needed
