extends Node2D

var index = 0

func _ready():
	$textbox.connect("text_panel_started", self, "next_step")
	$textbox.connect("text_panel_finished", self, "next_step")
	
	$textbox.add_texts(["En un mundo donde nadie es feliz, y la gente solo sabe llorar,"])
	$textbox.add_texts(["nace Bife","Un ser con el poder de curar la tristeza con piñas."])
	$textbox.add_texts(["Bife! tu misión es difícil pero no imposible! no dejes que los infelices te frenen, Bife!!" ])
	$textbox.add_texts(["Cagalos a trompadas!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"])

func next_step(textbox):
	match index:
		3:
			$Sprite.visible = true

	index += 1
