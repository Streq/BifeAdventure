extends Node2D



func _ready():
	if Globals.get_event(Globals.EVENT.tutorial_completed):
		queue_free()
	if has_node("change_text_area"):
		$change_text_area.connect("change_text", self, "_on_change_text")
	
	

func _on_change_text(text):
	$text.text = text

func leave():
	queue_free()
