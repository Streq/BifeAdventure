extends Hitbox
class_name Hurtbox
tool

func _ready():
	connect("area_entered",self, "_on_area_entered")
	pass
func _on_area_entered(area : Area2D):
	area._on_hurtbox(self)


func receive_knockback(knockback:Vector2) -> bool:
	get_body().receive_knockback(knockback)
	return true

func receive_flinch(knockback: Vector2, damage: float) -> bool:
	get_body().flinch(knockback, damage)
	return true

func receive_damage(damage : float) -> bool:
	get_body().receive_damage(damage)
	return true

func receive_grab() -> bool:
	return false
