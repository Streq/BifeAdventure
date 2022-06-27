extends Polygon2D
export (NodePath) onready var col = get_node(col) as CollisionPolygon2D

func _ready():
	col.polygon = polygon
	col.global_transform = global_transform
