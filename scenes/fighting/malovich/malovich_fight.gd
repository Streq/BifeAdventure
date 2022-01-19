extends Node2D

func player_win():
	Globals.set_event(Globals.EVENT.malovich_defeated, true)
	$Timer.start()
	yield($Timer,"timeout")
	$scene_change.trigger()

func player_lose():
	$Timer.start()
	yield($Timer,"timeout")
	$textbox.add_text("comiste")
	$textbox.add_text("vamos a hacer de cuenta que eso no paso")
	yield($textbox,"text_display_finished")
	Globals.respawn()

	


func _on_textbox_text_display_started(textbox):
	get_tree().paused = true


func _on_textbox_text_display_finished(textbox):
	get_tree().paused = false
