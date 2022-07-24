extends Node
#this is an add on to a state passive
#state -> passive -> this
export var should_be_true := true

onready var passive = get_parent()
onready var state = passive.get_parent()
onready var machine = state.get_parent()
var fighter
var is_connected = true
	

func _ready():
	yield(machine.get_parent(), "ready")
	fighter = state.root
	is_connected = state.is_connected("physics_process", passive, "physics_process")

func _physics_process(delta):
	if fighter.is_on_floor() == should_be_true:
		if !is_connected:
			state.connect("physics_process", passive, "physics_process")
			is_connected = true
	elif is_connected:
		state.disconnect("physics_process", passive, "physics_process")
		is_connected = false
	
