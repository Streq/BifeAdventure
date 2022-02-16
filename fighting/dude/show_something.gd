extends Label

export (String) var label := "something"
export (String) var what := ""

func _physics_process(delta):
	text = label + ":" + str(get_parent().get(what))
