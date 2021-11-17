extends Node2D

var direction := Vector2.ZERO
var speed := 200
var caster = null
var damage = 20
var dir = 1.0

func _ready():
	$hitbox.body = caster

func _physics_process(delta):
	position += speed * direction * delta


func _on_Area2D_body_entered(body):
	if body != caster: 
		$hitbox.set_deferred("monitoring",false)
		$Sprite.visible = false
		$particles_active.emitting = false
		$particles_blast.emitting = true
		yield(get_tree().create_timer(1.0),"timeout")
		queue_free()
		
