extends Node
signal trigger

export var should_be_true := true
export var enabled := true setget set_enabled


var ready = false
var connected = false
func set_enabled(val):
	enabled = val
	if ready:
		if !enabled and connected:
			get_parent().disconnect("physics_process", self, "physics_process")
			connected = false
		if enabled and !connected:
			get_parent().connect("physics_process", self, "physics_process")
			connected = true
		
		
func _ready():
	if enabled:
		get_parent().connect("physics_process", self, "physics_process")
	ready = true
	
func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	if fighter.is_on_floor() == should_be_true:
		emit_signal("trigger")
