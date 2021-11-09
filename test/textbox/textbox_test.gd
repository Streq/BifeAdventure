extends Node2D

onready var t = $textbox


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("display_text", self, "display_text")
	pass # Replace with function body.

func display_text(text):
	$textbox.add_texts(text)
	pass


func _on_textbox_text_display_started(textbox):
	get_tree().paused = true


func _on_textbox_text_display_finished(textbox):
	get_tree().paused = false
