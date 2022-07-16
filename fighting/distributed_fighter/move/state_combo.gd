extends Node

func _ready():
	get_parent().connect("ready",self,"_parent_ready")

func _parent_ready():
	var combo = []
	for child in get_children():
		combo.append(StateComboStep.new(child.state_name, child.min_time, child.max_time))
		child.queue_free()
		get_parent().requirement = combo
