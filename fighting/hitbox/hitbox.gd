extends Area2D

export var knockback := Vector2.ZERO
export var damage := 0.0
export var knockdown := false

var body = null
var caster = null

func _init():
	body = owner

func _activate_deferred():
	visible = true
	monitorable = true
	monitoring = true

func _deactivate_deferred():
	visible = false
	monitorable = false
	monitoring = false
func activate():
	call_deferred("_activate_deferred")


func deactivate():
	call_deferred("_deactivate_deferred")
	
func is_whitelisted(target):
	return target == body or target == caster or body.team && body.team == target.team

func apply_damage(target):
	target.health -= damage
	
func apply_knockback(target):
	var knock = knockback*Vector2(body.dir,1.0)
	target.velocity = knock
	if knock.x:
		target.dir = -sign(knock.x)


func get_knockdown():
	return knockdown
