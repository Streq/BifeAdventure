extends Node

export var dest_node : NodePath
export var dest_prop : String
export var source_node : NodePath
export var source_prop : String


func trigger():
	var source = get_node(source_node)
	var val = source.get_indexed(source_prop) if source_prop else source
	get_node(dest_node).set_indexed(dest_prop, val)
