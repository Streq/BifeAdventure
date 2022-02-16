extends Node


func interact(interacted, interactor, direction, grid):
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		player.set_process(false)
		player.set_process_input(false)
		player.set_physics_process(false)
	$fight_transition.play()
