extends Node2D
tool
onready var texture_rect = $TextureRect
onready var sprite = $Sprite
onready var texture_rect_2 = $TextureRect2
onready var texture_rect_3 = $TextureRect3
onready var texture_rect_4 = $TextureRect4

func _ready():
	sprite.palette = texture_rect_4.texture
	
