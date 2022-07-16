class_name StateComboStep
var state_name := ""
var min_time := -1.0
var max_time := -1.0

func _init(state_name: String, min_time: float, max_time: float):
	self.state_name = state_name
	self.min_time = min_time
	self.max_time = max_time
