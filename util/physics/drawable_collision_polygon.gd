extends Polygon2D
tool
export (NodePath) onready var col_path
onready var col = get_node(col_path) as CollisionPolygon2D

func _ready():
	col.polygon = polygon
	col.global_transform = global_transform
