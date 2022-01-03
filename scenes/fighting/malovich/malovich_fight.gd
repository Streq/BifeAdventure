extends Node2D

func player_win():
	Globals.events[Globals.EVENT.malovich_defeated] = true
	$scene_change.trigger()
