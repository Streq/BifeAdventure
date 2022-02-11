extends Area2D

signal applied_knockback(knockback)
signal applied_damage()

export var damage := 0.0
export var knockdown := false
export var hitstun := true

var body = null
var caster = null

onready var knockback = $knockback

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
	return target == body or target == caster or body.team and body.team == target.team

func apply_damage(target):
	emit_signal("applied_damage")
	target.health -= damage
	
func apply_knockback(target):
	knockback.apply_knockback(target, self)

func get_knockdown(target):
	return knockdown

func get_hitstun(target):
	return hitstun
