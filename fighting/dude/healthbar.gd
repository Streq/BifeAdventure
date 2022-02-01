extends ProgressBar

func _on_health_changed(val, max_val):
	self.value = val/max_val*100.0
	visible = (self.value<100.0)
