extends Hitbox
tool

func _ready():
	connect("area_entered",self, "_on_area_entered")
	
func _on_area_entered(area : Area2D):
	if area.get_body() != get_body():
		area.affect(self)
	

func receive_knockback(knockback:Vector2) -> bool:
	get_body().receive_knockback(knockback)
	return true

func receive_flinch(direction: Vector2) -> bool:
	get_body().flinch(direction)
	return true

func receive_damage(damage : float) -> bool:
	get_body().receive_damage(damage)
	return true

func receive_grab() -> bool:
	return false
