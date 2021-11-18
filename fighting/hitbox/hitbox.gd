extends Area2D

export var knockback := Vector2.ZERO
export var damage := 0.0

var body = null

func _init():
	body = owner

func apply_damage(target):
	target.health -= damage
	
func apply_knockback(target):
	var knock = knockback*Vector2(body.dir,1.0)
	target.velocity += knock
	if knock.x:
		target.dir = -sign(knock.x)
