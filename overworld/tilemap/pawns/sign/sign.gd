extends "res://overworld/tilemap/pawns/pawn.gd"

export (PoolStringArray) var interact_text := PoolStringArray(["mucho texto"])


func interact(_pawn, direction):
	Signals.emit_signal("display_text", interact_text)

