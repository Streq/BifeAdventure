extends Polygon2D
tool
export (NodePath) onready var col_path
export (bool) var force_update setget _update 

onready var col = get_node(col_path) as CollisionPolygon2D

func _ready():
	_update()


func _update(_val=false):
	col.polygon = polygon
	col.global_transform = global_transform

func _set(property: String, value):
	var res = property in self
	if res:
		_update()
	return res
