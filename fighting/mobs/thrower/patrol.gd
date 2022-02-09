extends State

export var frame_reaction_time := 2
export var strategy : NodePath
export var dir := 1.0

onready var peace = "walk_around"
onready var attack = "aim_attack"
onready var sight = $sight
onready var current = peace


func _physics_process(delta):
	sight.scale.x = owner.dir

func _on_sight_body_entered(body):
	if body.is_in_group("player"):
		get_node(strategy)._change_state(attack, null)

func _on_sight_body_exited(body):
	if body.is_in_group("player"):
		get_node(strategy)._change_state(peace, null)
