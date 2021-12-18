extends Area2D


signal change_text(text)

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("change_text",$text.text)
