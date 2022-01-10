extends Node2D

func player_win():
	Globals.set_event(Globals.EVENT.malovich_defeated, true)
	$Timer.start()

func _on_Timer_timeout():
	$scene_change.trigger()
