extends Control
tool
var text := "" setget set_text

func set_text(val):
	text = val
	$Label.text = val
