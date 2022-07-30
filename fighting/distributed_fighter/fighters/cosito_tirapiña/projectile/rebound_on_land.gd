extends Node

func trigger(val):
	trigger_no_args()

func trigger_no_args():
	var root = get_parent().get_body()
	root.velocity = -root.velocity*0.25
	root.state.current.goto("rebound")
