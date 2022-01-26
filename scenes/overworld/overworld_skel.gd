extends Node2D

onready var t = $textbox

func _ready():
	Signals.connect("display_text", self, "display_text")

func display_text(text):
	$textbox.add_texts(text)


func _on_textbox_text_display_started(textbox):
	get_tree().paused = true


func _on_textbox_text_display_finished(textbox):
	get_tree().paused = false


func _input(event):
	if event.is_action_pressed("menu"):
		save()
		display_text(["se guardo la partida"])
	pass

func save():
	Globals.save_game()
