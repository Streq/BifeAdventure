extends Node2D

func player_win():
	Globals.set_event(Globals.EVENT.malovich_defeated, true)
	$Timer.start()
	yield($Timer,"timeout")
	$scene_change.trigger()

func player_lose():
	$Timer.start()
	yield($Timer,"timeout")
	Globals.respawn()

	
