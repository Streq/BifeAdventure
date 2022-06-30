extends Hitbox
tool

func _ready():
	connect("area_entered",self, "_on_area_entered")
	
func _on_area_entered(area : Area2D):
	if area.get_body() != get_body():
		area.affect(self)
	

func receive_knockback(knockback : Vector2) -> bool:
	var body = get_body()
	body.velocity = knockback
	if knockback.x:
		body.facing_right = knockback.x < 0
	return true

func receive_flinch() -> bool:
	get_body().be_hurt()
	return true

func receive_damage(damage : float) -> bool:
	get_body().health -= damage
	return true

func receive_grab() -> bool:
	return false
