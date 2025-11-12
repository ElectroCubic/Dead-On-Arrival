extends Control
class_name Inventory

@onready var slots := $HBoxContainer.get_children()

func _ready():
	# Connect each slot to a function to handle clicks
	for slot in slots:
		slot.connect("pressed", _on_slot_pressed.bind(slot))
		slot.disabled = true  # empty at start

func add_item(item_data):
	if Globals.inventory_items.size() < slots.size():
		Globals.inventory_items.append(item_data)
		var index = Globals.inventory_items.size() - 1
		slots[index].get_child(-1).texture = item_data["icon"]
		slots[index].disabled = false
		slots[index].tooltip_text = "%s\n%s" % [item_data["name"], item_data["info"]]
	else:
		print("Inventory full!")

func _on_slot_pressed(slot):
	var index = slots.find(slot)
	if index >= 0 and index < Globals.inventory_items.size():
		var item = Globals.inventory_items[index]
		print("Selected:", item["name"], "-", item["info"])
		# TODO: Perform more actions later if needed
