extends CanvasLayer
onready var anim = $AnimationPlayer

func enter(is_indoors : bool):
	var anim_name = "enter_indoors" if is_indoors else "enter"
	anim.play(anim_name)
	
func exit(is_indoors : bool):
	var anim_name = "enter_indoors" if is_indoors else "enter"
	anim.play_backwards(anim_name)
