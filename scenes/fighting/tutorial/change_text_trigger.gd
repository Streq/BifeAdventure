extends Node

export var text := "" 
func trigger():
	get_parent().text = text
