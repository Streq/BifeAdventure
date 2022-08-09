extends Node2D
tool

onready var sprite = $Sprite
onready var red_palette = $red_palette
onready var somber_palette = $somber_palette
onready var green_palette = $green_palette


func _ready():
	sprite.palette = green_palette.texture
	
