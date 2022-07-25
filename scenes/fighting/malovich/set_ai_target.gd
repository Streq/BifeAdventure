extends Node

export var _target : NodePath

func _ready():
	var target = get_node(_target)
	var parent = get_parent()
	yield(parent,"ready")
	parent.get_node("AI").target = target
	
