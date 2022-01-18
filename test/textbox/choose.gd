extends Node2D


func _ready():
	$textbox.add_text("lmao o wow?")
	$textbox.add_text("contestame")
	var stop = false
	var opts = ["LMAO", "WOW", "no se man", "que te importa", "give me the truth and the whole truth bruno"]
	while !stop:
		$textbox.add_choose(opts)
		var choice = yield($textbox.menu, "selected")
		stop = true
		opts.remove(opts.find(choice))
		match choice:
			"LMAO":
				$textbox.add_text("sos un pillin asi que te gusta LMAO??")
			"WOW":
				$textbox.add_text("wowi")
			"no se man":
				$textbox.add_text("dale si que sabes")
				stop = false
			"que te importa":
				$textbox.add_text("sos re malo :(")
				$textbox.add_text("dale decime")
				stop = false
			_:
				$textbox.add_text("ISABELLA YOUR BOYFRIEND'S HERE")
				$textbox.add_choose(["TIME FOR DINNER"])
				choice = yield($textbox.menu, "selected")
				$textbox.add_text("dale decime")
				stop = false

		
				
