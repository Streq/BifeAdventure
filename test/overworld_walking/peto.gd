extends "res://tilemap/pawns/pawn.gd"

func interact():
	Signals.emit_signal("display_text", ["buenas", "che gordo disculpá pero te voy a tener que recagar a trompadas"])
