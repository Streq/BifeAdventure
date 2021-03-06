extends CanvasLayer

export var play_scene : PackedScene

func _ready():
	$menu.set_process_input(false)
	
func start_menu():
	$menu.visible = true
	$menu.add_entry("play", "play", true)

	var save_exists = ResourceLoader.exists(Globals.SAVE_PATH)
	$menu.add_entry("continue", "continue", save_exists)
	
	if save_exists:
		$menu.select_entry("continue")
	
	$menu.connect("selected",self,"_selected")
	
	$menu.set_process_input(true)
	set_process_input(false)
	
func _input(event):
	if event.is_action_pressed("A0"):
		$start.visible = false
		start_menu()

func _selected(entry:String):
	call("_"+entry)

func _play():
	get_tree().change_scene_to(play_scene)
	pass
	
func _continue():
	Globals.load_game()
	pass
