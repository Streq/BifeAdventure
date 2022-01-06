extends AnimationPlayer

export (NodePath) var textbox_path : NodePath
var mom
var dad
var bife
export (NodePath) var malovich_muerto
export (NodePath) var malovich
var malovich_house_entrance
func _ready():
	yield(get_tree().root, "ready")
	animate()

func animate():
	yield(text_prompt(["MAMA: Dios mio!"]), "completed")
	yield(walk(mom,[Vector2(0,0), Vector2(1,1)]), "completed")
	yield(text_prompt(["MAMA: Hijo, estas bien?"]), "completed")
	yield(wait(1.0), "completed")
	yield(text_prompt([
		"MAMA: Lo mataste!", 
		"PAPA: Lo hiciste mierda Bife",
		"BIFE: xD"]), "completed")
	yield(wait(0.5), "completed")
	get_node(malovich_muerto).visible = false
	get_node(malovich).visible = true
	yield(get_tree(),"idle_frame")
	yield(wait(0.5), "completed")
	yield(text_prompt([
		"MAMA: Hijo!", 
		"MAMA: como te sentis?", 
		"SANTI: creo q"]), "completed")
	yield(wait(0.5), "completed")
	yield(text_prompt([
		"SANTI: creo que nunca estuve tan feliz en mi vida",
		"PAPA: ah ta muy bueno eso!!",
		"MAMA: ay hijo",
		"MAMA: *lagrimeo*", 
		"MAMA: que alegria, no sabes el susto que me pegue",
		"SANTI: perdon Bife, perdon de corazon, y gracias por todo",
		"BIFE: te perdono y denada",
		"PAPA: gracias Bife",
		"BIFE: denada",
		"MAMA: gracias Bife!!",
		"BIFE: denada"]), "completed")
	yield(fade_out(), "completed")
	overworld_goto(Overworld.map[Globals.ROOM.my_hometown], malovich_house_entrance)
	
	
func text_prompt(text):
	var textbox = get_node(textbox_path)
	textbox.add_texts(text)
	yield(textbox,"text_display_finished")
	
func walk(character, positions):
	yield(get_tree(),"idle_frame")
	pass

func wait(time):
	yield(get_tree().create_timer(time), "timeout")

func fade_out():
	yield(get_tree(),"idle_frame")
	pass

func overworld_goto(scene, position):
	yield(get_tree(),"idle_frame")
	pass
