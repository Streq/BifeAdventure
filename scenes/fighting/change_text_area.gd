extends Area2D


signal change_text(text)

func _on_body_entered(body):
	emit_signal("change_text",$text.text)
