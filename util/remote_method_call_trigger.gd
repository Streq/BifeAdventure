extends Node


export (NodePath) var caller
export (String) var method
export (Array) var args


func trigger():
	var c = caller if caller else get_parent()
	c.callv(method, args)
