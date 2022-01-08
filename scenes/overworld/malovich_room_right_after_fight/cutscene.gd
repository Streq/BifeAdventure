extends AnimationPlayer

export (NodePath) var textbox_path : NodePath
export (NodePath) var mom_path : NodePath
onready var mom: OverworldCharacter = get_node(mom_path)

export (NodePath) var dad_path : NodePath
onready var dad: OverworldCharacter = get_node(dad_path)

export (NodePath) var bife_path : NodePath
onready var bife: OverworldCharacter = get_node(bife_path)

export (NodePath) var malovich_muerto_path : NodePath
onready var malovich_muerto: Sprite = get_node(malovich_muerto_path)

export (NodePath) var malovich_path : NodePath
onready var malovich: OverworldCharacter = get_node(malovich_path)



var malovich_house_entrance
func _ready():
	yield(get_tree().root, "ready")
	animate()

func animate():
	malovich.turn(Vector2.RIGHT)
	bife.turn(Vector2.LEFT)
	
	bife.controller.active = false
	yield(text_prompt(["MAMA: Dios mio!"]), "completed")
	yield(walk(mom,[Vector2(-4,0), Vector2(0,1)]), "completed")
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
	yield(wait(0.4), "completed")
	malovich.turn(Vector2.DOWN)
	yield(wait(0.4), "completed")
	malovich.turn(Vector2.UP)
	yield(wait(0.4), "completed")
	malovich.turn(Vector2.LEFT)
	yield(wait(0.4), "completed")
	malovich.turn(Vector2.RIGHT)
	yield(wait(0.4), "completed")
	
	yield(text_prompt([
		"SANTI: creo que nunca estuve tan feliz en mi vida",
		"PAPA: ah ta muy bueno eso!!",
		"MAMA: ay hijo",
		"MAMA: *lagrimeo*", 
		"MAMA: que alegria, no sabes el susto que me pegue",
		"SANTI: no entiendo por que, pero esa paliza desperto algo en mi",
		"BIFE: es porque tengo poderes",
		"PAPA: ah si?"]),"completed")
	
	bife.turn(Vector2.UP)
	yield(wait(0.2), "completed")
	yield(text_prompt([
		"BIFE: si",
		"PAPA: y que tipo haces feliz a la gente con trompadas?",
		"BIFE: si exactamente",
		"SANTI: perdon Bife, perdon de corazon, y gracias por todo"]), "completed")
	bife.turn(Vector2.LEFT)
	yield(wait(0.2), "completed")
	yield(text_prompt([
		"BIFE: te perdono y denada",
		"PAPA: gracias Bife",
		"BIFE: denada",
		"MAMA: gracias Bife!!",
		"BIFE: denada"]), "completed")
	yield(fade_out(), "completed")
	overworld_goto(Overworld.map[Globals.ROOM.my_hometown], malovich_house_entrance)
	
	bife.controller.active = true
	
		
#	var cutscene = [
#		TextSeq.new(["MAMA: Dios mio!"]),
#		WalkSeq.new(mom,[Vector2(0,3), Vector2(-5,0)]),
#		TextSeq.new(["MAMA: Hijo, estas bien?"]),
#		WaitSeq.new(1.0),
#		TextSeq.new([
#			"MAMA: Lo mataste!", 
#			"PAPA: Lo hiciste mierda Bife",
#			"BIFE: xD"]),
#		WaitSeq.new(0.5),
#	]
	
func play_cutscene(cutscene):
	for step in cutscene:
		yield(step.play(), "completed")

func text_prompt(text):
	var textbox = get_node(textbox_path)
	textbox.add_texts(text)
	yield(textbox,"text_display_finished")

class WalkControllerSequence:
	var offset := Vector2.ZERO
	var character
	func _init(character, offset):
		self.character = character
		self.offset = offset
	
	func play():
		var controller = character.controller
		character.controller = self
		while offset != Vector2.ZERO:
			yield(character, "finish_step")
			offset -= Vector2(sign(offset.x), sign(offset.y))
		character.controller = controller
		
	func get_direction(_actor) -> Vector2:
		var step = Vector2(sign(offset.x), sign(offset.y))
		return step

	func get_interact(_actor) -> bool:
		return false


func walk(character, offsets):
	for offset in offsets:
		var walk_cont = WalkControllerSequence.new(character, offset)
		yield(walk_cont.play(), "completed")
	
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


#class Seq:
#	func play():
#		pass
#
#class TextSeq extends Seq:
#	var text
#
#	func _init(text):
#		self.text = text
#
#	func play():
#		var textbox = Engine.get_main_loop().get_nodes_in_group("textbox")[0]
#		textbox.add_texts(text)
#		yield(textbox,"text_display_finished")
#
#class WalkSeq extends Seq:
#	var character
#	var offsets
#	func _init(character, offsets):
#		self.character = character
#		self.offsets = offsets
#
#	func play():
#		yield(Engine.get_main_loop(), "idle_frame")
#
#class WaitSeq extends Seq:
#	var seconds
#	func _init(seconds):
#		self.seconds = seconds
#
#	func play():
#		yield(Engine.get_main_loop().create_timer(seconds), "timeout")
#
#class FadeOutSeq extends Seq:
#	func play():
#		yield(Engine.get_main_loop(), "idle_frame")
