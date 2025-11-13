extends Node

class_name Global

@warning_ignore("unused_signal")
signal stat_change

var star_level: int = 3:
	set(value):
		star_level = value
		stat_change.emit()
var investigation: bool = false
var is_dialogue_playing: bool = false
var inventory_items: Array = []
var case_log_entries: Array = []

func add_item(item_data: Dictionary):
	if not inventory_items.has(item_data):
		inventory_items.append(item_data)

func add_log_entry(text: String):
	if not case_log_entries.has(text):
		case_log_entries.append(text)

func clear_all():
	inventory_items.clear()
	case_log_entries.clear()
	
var collected_item_ids: Array = []

func mark_item_collected(item_id: String):
	if item_id not in collected_item_ids:
		collected_item_ids.append(item_id)

func has_item_id(item_id: String) -> bool:
	return item_id in collected_item_ids
