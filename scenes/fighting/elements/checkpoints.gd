extends Node2D

var current_checkpoint = null


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.connect("checkpoint",self, "_on_checkpoint")

func respawn(player):
	player.velocity = Vector2.ZERO
	player.position = current_checkpoint
	player.facing_right = true

func _on_checkpoint(checkpoint):
	current_checkpoint = checkpoint.position
