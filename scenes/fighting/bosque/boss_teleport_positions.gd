extends Node2D

var mago = null
onready var current_position = get_node("0")

func _ready():
	for child in get_children():
		child.connect("mago_exited", self, "teleport")



func teleport():
	yield(get_tree().create_timer(0.2),"timeout")
	var positions = get_children()
	var i = positions.find(current_position)
	i = (i+1)%positions.size()
	current_position = positions[i]
	mago.global_position = current_position.global_position
	
