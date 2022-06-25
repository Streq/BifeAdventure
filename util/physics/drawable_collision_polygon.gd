extends Polygon2D
tool
export (NodePath) onready var col = get_node(col) as CollisionPolygon2D if col else null

func _ready():
	col.polygon = polygon
	col.global_transform = global_transform
