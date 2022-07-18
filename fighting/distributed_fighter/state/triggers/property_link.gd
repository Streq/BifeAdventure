extends Node

export var dest_node : NodePath
export var dest_prop : String
export var source_node : NodePath
export var source_prop : String


func trigger():
	var val = get_node(source_node).get_indexed(source_prop)
	get_node(dest_node).set_indexed(dest_prop, val)
