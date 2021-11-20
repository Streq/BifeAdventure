extends Node

export (PoolStringArray) var states_from := ["idle"]
export (String) var state_to := ""
export (PoolVector2Array) var dirs := []
export (String) var action := "attack"
export (bool) var on_finish := false
func check_satisfy():
	return owner.controller[action] \
		and states_from.find(owner.state.current) != -1 \
		and (dirs.empty() or dirs.find(owner.controller.direction*Vector2(owner.dir,1.0)) != -1)

func enter():
	if on_finish:
		owner.state._change_state_soft(state_to, null)
	else:
		owner.state._change_state(state_to, null)
	
