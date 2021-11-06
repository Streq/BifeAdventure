extends Node2D

onready var grid = $grid
onready var triggers = $triggers

func _ready():
	grid.triggers = triggers
