extends Node2D


func _ready():
	
	var my_str0 = "Hola a todos, yo soy el leon, rugio la bestia en medio de la avenida, todos corrieron, sin entender, el panic show a plena luz del dia, por favor no huyan de mi, yo soy el rey, de un mundo perdido"
	var my_str1 = "yo soy tu amigo fiel. Yo soy tu amigo fiel, caminando, por el parque, yo soy tu amigo fiel, VAMOS TODOS, yo soy tu amigo fiel"
	var my_str2 = "0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789 0123456789"
	
	
	$textbox.add_text(my_str0)
	$textbox.add_text(my_str1)
	$textbox.add_text(my_str2)
