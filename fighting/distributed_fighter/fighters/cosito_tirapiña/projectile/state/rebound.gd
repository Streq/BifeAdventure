extends FighterState
onready var free_timer = $free_timer


func _enter(params):
	root.connect("terrain_collision", self, "_on_terrain_collision")

func _exit():
	root.disconnect("terrain_collision", self, "_on_terrain_collision")

func _on_terrain_collision(velocity, collision):
	root.velocity = velocity.bounce(collision.normal)*0.25
	root.collision_layer=0
	root.collision_mask=0
	free_timer.start()
	pass
