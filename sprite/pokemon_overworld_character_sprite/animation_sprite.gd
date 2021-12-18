tool
extends Sprite

var idle_down_frame := 0 setget set_idle_down_frame

var current_frame := 0 setget set_current_frame

func _process(delta):
	frame = idle_down_frame+current_frame
	
func _ready():
	frame = idle_down_frame

func set_current_frame(val):
	current_frame = val
	frame = idle_down_frame+current_frame
	
func set_idle_down_frame(val):
	idle_down_frame = val
	set_current_frame(current_frame)

func flip_h():
	flip_h = !flip_h
	
func flip_v():
	flip_v = !flip_v
