extends FighterState

var frames = 0

func _enter(params):
	frames = params[0]

# Called during _physics_process
func _physics_update(delta: float):
	frames -= 1
	if frames <= 0:
		goto("idle")
