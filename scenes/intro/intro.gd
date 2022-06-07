extends Node2D

export(String, FILE, "*.tscn") var next_scene

var index = 0

func _ready():
	Textbox.connect("text_panel_started", self, "next_step_textbox")
	Textbox.connect("text_panel_finished", self, "next_step_textbox")
	Textbox.connect("text_display_started", self, "next_step_textbox")
	Textbox.connect("text_display_finished", self, "next_step_textbox")
	$AnimatedSprite.connect("animation_finished", self, "next_step")
	
	Textbox.add_texts(["En un mundo donde nadie es feliz, y la gente solo sabe llorar,"])
	Textbox.add_texts(["nace Bife","Un ser con el poder de curar la tristeza con trompadas,"])
	Textbox.add_texts(["y con el deseo de usar dicho poder exhaustivamente."])
	Textbox.add_texts(["Bife! tu misión es difícil pero no imposible! no dejes que los infelices te frenen, Bife!!" ])
	Textbox.add_texts(["Cagalos a trompadas!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"])

func next_step_textbox(textbox):
	next_step()


func next_step():
	print_debug(index)
	match index:
		4:
			$AnimatedSprite.visible = true
		13:
			$AnimatedSprite.play("default")
		14:
			$AnimatedSprite.visible = false
			$Sprite.visible = true
			yield(get_tree().create_timer(0.5),"timeout")
			get_tree().change_scene(next_scene)
	index += 1

