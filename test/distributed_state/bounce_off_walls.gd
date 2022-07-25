extends Node


export var SPLASH : PackedScene
export (float, 0.0, 1.0) var bounce := 1.0
export (float, 0.0, 1000.0) var threshold := 90.0



func _ready():
	get_parent().connect("physics_process", self, "physics_process")
	get_parent().connect("entered", self, "entered")
	get_parent().connect("exit", self, "exit")
	

func entered():
	var state = get_parent()
	var fighter = state.root
	fighter.connect("terrain_collision", self, "terrain_collision")

func exit():
	var state = get_parent()
	var fighter = state.root
	fighter.disconnect("terrain_collision", self, "terrain_collision")


func terrain_collision(velocity : Vector2, collision : KinematicCollision2D):
	var state = get_parent()
	var fighter = state.root
	var normal = collision.normal
	var projected = velocity.project(normal)
	if projected.length_squared()>threshold*threshold:
		if normal.dot(velocity)<0:
			var bounced = velocity.bounce(normal)
			fighter.velocity = bounced*bounce
			if fighter.velocity.x:
				fighter.facing_right = fighter.velocity.x<0.0
			
			#splash particles
			var splash : CPUParticles2D = SPLASH.instance()
			splash.direction = normal
#			splash.color = Color.cornflower
			splash.spread = 90
			splash.initial_velocity = velocity.length()/5.0
			splash.gravity = Vector2()
			splash.emitting = true
			get_tree().current_scene.add_child(splash)
			splash.global_position = collision.position
			
			
		else:
			fighter.velocity = velocity
		
func physics_process(delta):
	pass
