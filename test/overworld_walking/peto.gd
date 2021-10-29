extends "res://tilemap/pawns/pawn.gd"

enum Direction {down, up, right, left}
const DIRS = [Vector2.DOWN, Vector2.UP, Vector2.RIGHT, Vector2.LEFT]

export(Direction) var init_look_dir
export (PoolStringArray) var interact_text := PoolStringArray(["mucho texto"])
export (bool) var fix_look_dir := false


var look_dir := Vector2.DOWN


func interact(pawn, direction):
	turn(-direction)
	Signals.emit_signal("display_text", interact_text)
	set_process(false)

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
			$AnimationPlayer.play("idle_down")
		Vector2.UP:
			$AnimationPlayer.play("idle_up")
		Vector2.LEFT:
			$AnimationPlayer.play("idle_left")
		Vector2.RIGHT:
			$AnimationPlayer.play("idle_right")
