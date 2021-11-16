extends Node

export (PoolStringArray) var states_from := ["idle"]
export (String) var state_to := "jab"
export (PoolVector2Array) var dirs := []

func check_satisfy():
	return owner.controller.attack \
		and states_from.find(owner.state.current) != -1 \
		and (dirs.empty() or dirs.find(owner.controller.direction*Vector2(owner.dir,1.0)) != -1)

func enter():
	owner.state._change_state(state_to, null)
	
