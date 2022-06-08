extends Node2D

func player_win():
	Globals.set_event(Globals.EVENT.malovich_defeated, true)
	$Timer.start()
	yield($Timer,"timeout")
	$scene_change.trigger()

func player_lose():
	$Timer.start()
	yield($Timer,"timeout")
	Textbox.add_text("uh, ehhh")
	Textbox.add_text("voy a hacer como que eso no paso")
	yield(Textbox,"text_display_finished")
	Globals.respawn()

	
func _ready():
	Textbox.connect("text_display_started", self, "_on_textbox_text_display_started")
	Textbox.connect("text_display_finished", self, "_on_textbox_text_display_finished")

func _on_textbox_text_display_started(textbox):
	get_tree().paused = true


func _on_textbox_text_display_finished(textbox):
	get_tree().paused = false
