extends CanvasLayer

func _ready():
	$menu.set_process_input(false)

func start_menu():
	$menu.visible = true
	$menu.add_entry("play", "play", true)
	$menu.add_entry("continue", "continue", true)
	
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
	get_tree().change_scene("res://test/mobs/mobs.tscn")
	pass
	
func _continue():
	pass