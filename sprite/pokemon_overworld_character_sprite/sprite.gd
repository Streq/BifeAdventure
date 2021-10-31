tool
extends Node2D

export (int) var idle_down_frame := 0 setget set_idle_down_frame

func set_idle_down_frame(val):
	idle_down_frame = val
	$Sprite.idle_down_frame = idle_down_frame
