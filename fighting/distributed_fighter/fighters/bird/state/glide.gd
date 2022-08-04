extends FighterState

export var _normal : Vector2 = Vector2(1,-1)

var normal := Vector2()

export var drag := 0.1

func _ready():
	normal = _normal.normalized()

func _physics_update(delta: float):
	
	var n = normal*Vector2(root.get_facing_dir(),1.0)
	if n.dot(root.velocity)<0:
		var projection = root.velocity.project(n)
		root.velocity -= projection*drag
