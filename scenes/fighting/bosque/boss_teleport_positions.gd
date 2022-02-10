extends Node2D

var mago = null

func _ready():
	for child in get_children():
		child.connect("mago_exited", self, "teleport")


func teleport(last_position):
	yield(get_tree().create_timer(0.2),"timeout")
	var positions = get_children()
	var i = positions.find(last_position)
	i = (i+1)%positions.size()
	
	mago.global_position = positions[i].global_position
