extends Area2D
signal checkpoint(checkpoint)

var enabled := true


func _ready():
	pass # Replace with function body.





func _on_checkpoint_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("checkpoint", self)
		enabled = false
