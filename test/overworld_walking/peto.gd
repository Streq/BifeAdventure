extends "res://tilemap/pawns/pawn.gd"

enum Direction {down, up, right, left}
const DIRS = [Vector2.DOWN, Vector2.UP, Vector2.RIGHT, Vector2.LEFT]

export(Direction) var init_look_dir
export (PoolStringArray) var interact_text := PoolStringArray(["mucho texto"])
export (bool) var fix_look_dir := false

onready var anim = $character_sprite/AnimationPlayer


var look_dir := Vector2.DOWN


func interact(_pawn, direction):
	turn(-direction)
	Signals.emit_signal("display_text", interact_text)

func _ready():
	init_look_dir = DIRS[init_look_dir]
	turn(init_look_dir)

func _process(delta):
	if fix_look_dir and look_dir != init_look_dir:
		turn(init_look_dir)

func turn(direction):
	look_dir = direction
	match direction:
		Vector2.DOWN:
			anim.play("idle_down")
		Vector2.UP:
			anim.play("idle_up")
		Vector2.LEFT:
			anim.play("idle_left")
		Vector2.RIGHT:
			anim.play("idle_right")
