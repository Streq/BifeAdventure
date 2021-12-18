extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var blue_value = 0.5
	$pokemon_gsc_overworld_characters_grey.material.set_shader_param("blue", blue_value)
