extends Hitbox
class_name Hurtbox
tool

export var flinch_enabled = true
export var knockback_enabled = true
export var damage_enabled = true

func _ready():
	connect("area_entered",self, "_on_area_entered")
	pass
func _on_area_entered(area : Area2D):
	area._on_hurtbox(self)

func receive_knockback(knockback:Vector2) -> bool:
	if knockback_enabled:
		get_body().receive_knockback(knockback)
	return knockback_enabled

func receive_flinch(knockback: Vector2, damage: float) -> bool:
	if flinch_enabled:
		get_body().flinch(knockback, damage)
	return flinch_enabled

func receive_damage(damage : float) -> bool:
	if damage_enabled:
		get_body().receive_damage(damage)
	return damage_enabled

func receive_grab() -> bool:
	return false
