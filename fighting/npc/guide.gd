extends Node2D

func _ready():
	if has_node("change_text_area"):
		$change_text_area.connect("change_text", self, "_on_change_text")
	

func _on_change_text(text):
	$text.text = text
