extends Node2D

func _process(delta):
	$Label.visible = $AnimationTree.get("parameters/playback").is_playing()

func _input(event):
	if event.is_action_pressed("B0"):
		yield(get_tree(),"idle_frame")
		$AnimationTree["parameters/conditions/advance"] = true
		yield(get_tree(),"idle_frame")
		$AnimationTree["parameters/conditions/advance"] = false
