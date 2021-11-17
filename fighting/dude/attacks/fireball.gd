extends Node2D

var direction := Vector2.ZERO
var speed := 200
var caster = null
var knockback = 200
var damage = 20
func _physics_process(delta):
	position += speed * direction * delta


func _on_Area2D_body_entered(body):
	if body != caster: 
		if body.is_in_group("fighter"):
			body.velocity += Vector2(direction.x, -0.6)*knockback
			body.health -= damage
			body.dir = -direction.x
			body.get_node("state")._change_state("hurt", null)
		$Area2D.set_deferred("monitoring",false)
		$Sprite.visible = false
		$particles_active.emitting = false
		$particles_blast.emitting = true
		yield(get_tree().create_timer(1.0),"timeout")
		queue_free()
		
