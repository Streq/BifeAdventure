extends Node2D


func player_lose():
	$Timer.start()
	yield($Timer,"timeout")
	$textbox.add_text("uh, ehhh")
	$textbox.add_text("voy a hacer como que eso no paso")
	yield($textbox,"text_display_finished")
	Globals.respawn()
