extends Label

const format =  "Press [%s] to start"

func _ready():
	text = format % (InputMap.get_action_list("A0")[0] as InputEvent).as_text()

func _on_Timer_timeout():
	visible = !visible

func _input(event):
	pass
