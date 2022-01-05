extends AnimationPlayer

var mom
var dad
var bife
var malovich_muerto
var malovich
var malovich_house_entrance

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
	malovich_muerto.visible = false
	malovich.visible = true
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
	overworld_goto(Overworld.map["hometown"], malovich_house_entrance)
	
	
func text_prompt(text):
	pass
	
func walk(character, positions):
	pass

func wait(time):
	yield(get_tree().create_timer(time), "timeout")

func fade_out():
	pass

func overworld_goto():
	pass
