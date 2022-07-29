extends Node
export var to := ""

func trigger():
	get_parent().goto(to)
