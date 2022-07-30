extends FighterState

func _enter(params):
	root.connect("terrain_collision", self, "_on_terrain_collision")

func _exit():
	root.disconnect("terrain_collision", self, "_on_terrain_collision")

func _on_terrain_collision(velocity, collision):
	root.velocity = velocity.bounce(collision.normal)*0.25
	root.state.current.goto("rebound")
	pass
