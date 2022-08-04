extends FighterState



onready var normal := $normal

export var drag := 0.1


func _physics_update(delta: float):
	var n = normal.direction * Vector2(root.get_facing_dir(),1.0)
	if n.dot(root.velocity)<0:
		var projection = root.velocity.project(n)
		root.velocity -= projection*drag
