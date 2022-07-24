extends Area2D

var active = false

func _ready():
	connect("area_entered",self,"_on_body_entered")

func _on_body_entered(body):
	if !active:
		active = true
		Textbox.add_texts(["PEPE: faaa BIFE, la tienes CLARÍSIMA"])
		yield(Textbox,"text_display_finished")
		get_parent().get_node("text").visible = true
		get_parent().get_node("stuck_area").queue_free()
