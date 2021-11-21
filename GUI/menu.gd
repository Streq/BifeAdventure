extends MarginContainer

signal selected(name)


onready var entries_node = $CenterContainer/HBoxContainer/options/entries

export var entry : PackedScene

var entries = {}
var entries_index = 0
var selected_entry = null
var selected_name = ""

func _input(event):
	var dir = 0
	if event.is_action_pressed("down0"):
		dir = 1
	elif event.is_action_pressed("up0"):
		dir = -1
	elif event.is_action_pressed("A0"):
		emit_signal("selected", selected_entry.name)
	
	
	if dir and !entries.empty():
		_offset_index(dir)
		while !_can_select(entries_index):
			_offset_index(dir)
			
		_select(entries_index)

func _offset_index(dir):
	entries_index = (entries_index + dir + entries_node.get_child_count()) % entries_node.get_child_count()

func _can_select(index):
	return entries_node.get_child(index).enabled

#func _add_entry(name:String, text:String, enabled:bool):
#	call_deferred("_deferred_add_entry", name, text, enabled)

func add_entry(name:String, text:String, enabled:bool):
	remove_entry(name)
	var new_entry = entry.instance()
	entries_node.add_child(new_entry)
	new_entry.name = name
	new_entry.text = text
	new_entry.enabled = enabled
	entries[name] = new_entry
	if entries.size() == 1:
		_select(0)

func remove_entry(name:String):
	var e = entries.get(name)
	if e != null:
		entries_node.remove_child(e)
	entries[name] = null

func _select(index):
	for e in entries_node.get_children():
		e.selected = false
	selected_entry = entries_node.get_child(index)
	selected_entry.selected = true
	selected_name = selected_entry.name
	entries_index = index
	
	
