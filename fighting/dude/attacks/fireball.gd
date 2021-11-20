extends Node2D

var direction := Vector2.ZERO
var speed := 200
var caster = null
var damage = 20
var dir = 1.0

func _ready():
	$hitbox.body = self
	$hitbox.caster = caster

func _physics_process(delta):
	position += speed * direction * delta


func _on_hitbox_area_entered(area):
	if area.owner != caster: 
		explode()

func _on_terrainbox_body_entered(body):
	explode()
	

func explode():
	$particles_blast.direction = Vector2(-dir,0)
	speed = 0
	$hitbox.set_deferred("monitoring",false)
	$hitbox.set_deferred("monitorable",false)
	$terrainbox.set_deferred("monitoring",false)
	$terrainbox.set_deferred("monitorable",false)
	$Sprite.visible = false
	$particles_active.emitting = false
	$particles_blast.emitting = true
	yield(get_tree().create_timer(1.0),"timeout")
	queue_free()



