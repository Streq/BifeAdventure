tool
extends Sprite



onready var idle_down_frame = frame 
var current_frame := 0 setget set_current_frame

func _process(delta):
	frame = idle_down_frame+current_frame
	
func _ready():
	frame = idle_down_frame

func set_current_frame(val):
	current_frame = val
	frame = idle_down_frame+current_frame
