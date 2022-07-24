extends CanvasLayer
onready var anim = $AnimationPlayer

func enter(is_indoors : bool):
	anim.play(_get_anim(is_indoors))
	
func exit(is_indoors : bool):
	anim.play_backwards(_get_anim(is_indoors))
	
func _get_anim(is_indoors: bool):
	return "enter_light"
#	return "enter_dark" if is_indoors else "enter_light"
