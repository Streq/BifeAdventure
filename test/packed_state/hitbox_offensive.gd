extends Hitbox
class_name OffensiveHitbox
tool

signal applied_damage(damage)
signal applied_knockback(knockback)
signal lost_rebound()
signal won_rebound()


export var knockback := 0.0

#var global_knockback setget , get_global_knockback

export var damage := 0.0
export var can_hit_same_fighter_more_than_once := false
export var SPLASH : PackedScene
export var HIT_SPLASH : PackedScene

#if several hitboxes of this attack land on the same frame, only the one with lowest priority will land
export var hit_priority := 0

export var clang := true
var enabled = true


export var direction := Vector2.RIGHT setget set_direction
export var direction_degrees := 0.0 setget set_direction_degrees
var direction_rads := 0.0

var hit_fighters = []
var ignore_this_frame = []

func _ready():
	connect("activate", self, "_on_active")
	connect("area_entered", self, "_on_area_entered")


func _on_active():
	hit_fighters = []

func on_hurtbox(hurtbox: Area2D):
	var target = hurtbox.get_body()
	if should_affect(target):
		hit_fighters.append(target)
		var fighter = get_body()
		var knockback_vec = get_knockback_vector()
		var pre_health = target.health
		hurtbox.receive_flinch(knockback_vec, damage)
		if hurtbox.receive_damage(damage):
			emit_signal("applied_damage", damage)
		if hurtbox.receive_knockback(knockback_vec):
			emit_signal("applied_knockback", knockback_vec)


#		var splash = SPLASH.instance()
#		splash.modulate = Color.orangered
#		get_tree().current_scene.add_child(splash)
#		splash.global_position = fighter.global_position + (target.global_position-fighter.global_position)/2.0

		
		#HITSTUN
		var stun_time = get_physics_process_delta_time()*clamp(damage, 5.0, 20.0)
		
		fighter.pause = true
		var hitsplash_pos = fighter.global_position + (target.global_position-fighter.global_position)/2.0
		target.hitstun(stun_time)
		hitsplash(hitsplash_pos, int(pre_health-target.health), get_facing_dir(), knockback)
		yield(get_tree().create_timer(stun_time, false),"timeout")
		fighter.pause = false
		
		
func hitsplash(global_pos : Vector2, amount: int, direction : Vector2, velocity: float):
	if amount > 0:
		var hit_splash : CPUParticles2D = HIT_SPLASH.instance()
		hit_splash.emitting = true
		hit_splash.modulate = Color.darkorange
		hit_splash.amount = amount
		if velocity>100.0:
			hit_splash.direction = direction
			hit_splash.initial_velocity = velocity
		else:
			hit_splash.initial_velocity = 100
			hit_splash.spread = 180
	#	hit_splash.damping = velocity*2.5
		get_tree().current_scene.add_child(hit_splash)
		hit_splash.global_position = global_pos

func on_hitbox(hitbox: Area2D):
	if clang and hitbox.clang:
		var target = hitbox.get_body()
		if should_affect(target):
			ignore_this_frame.append(target)
			var fighter = get_body()
			var target_damage = hitbox.damage
			fighter.pause = true
			yield(get_tree(), "physics_frame")
			
			ignore_this_frame = []
			var splash = SPLASH.instance()
			get_tree().current_scene.add_child(splash)
			splash.global_position = fighter.global_position + (target.global_position-fighter.global_position)/2.0
			
			yield(get_tree().create_timer(get_physics_process_delta_time()*5, false),"timeout")
			
			fighter.pause = false
			if damage < target_damage + 5.0:
				get_body().rebound(int(max(knockback, hitbox.knockback)*0.075), hitbox.get_knockback_vector()*0.5)
				emit_signal("lost_rebound")
			else:
				emit_signal("won_rebound")
			
			
func set_direction(val : Vector2):
	if val:
		direction = val.normalized()
		direction_rads = direction.angle()
		direction_degrees = rad2deg(direction_rads)
	else:
		direction = val
		direction_rads = NAN
		direction_degrees = NAN
	property_list_changed_notify()

func set_direction_degrees(val : float):
	if is_nan(val):
		direction = Vector2.ZERO
	else:
		direction = Vector2.RIGHT.rotated(deg2rad(val))
	direction_degrees = val
	direction_rads = deg2rad(val)
	property_list_changed_notify()

func should_affect(target):
	return (
		enabled
		and target != get_body() 
		and (can_hit_same_fighter_more_than_once or !hit_fighters.has(target))
		and !ignore_this_frame.has(target)
	)
func get_facing_dir():
	return Vector2(get_body().get_facing_dir()*direction.x, direction.y).rotated(get_body().global_rotation)
func get_knockback_vector():
	return get_facing_dir()*knockback

func _on_area_entered(area:Hitbox):
	area._on_hitbox(self)
