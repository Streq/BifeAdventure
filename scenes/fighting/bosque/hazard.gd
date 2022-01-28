extends Node2D

export var dir := 1.0
export var team := 0

onready var hitbox = $hitbox

func _ready():
	for child in hitbox.get_children():
		child.body = self
