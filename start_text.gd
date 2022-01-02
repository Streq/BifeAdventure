extends Label

export var format :=  "Press [%s] to start"

func _ready():
	text = format % (InputMap.get_action_list("A0")[0] as InputEvent).as_text()
