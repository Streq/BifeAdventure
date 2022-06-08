extends Node


func _ready():
	Textbox.connect("text_display_started",self, "_on_text_display_started")
	Textbox.connect("text_display_finished",self,"_on_text_display_finished")

func _on_text_display_started(textbox):
	get_tree().paused = true
	
func _on_text_display_finished(textbox):
	get_tree().paused = false
