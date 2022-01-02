extends Timer

func _ready():
	connect("timeout", self, "_on_timeout")

func _on_timeout():
	get_parent().visible = !get_parent().visible
