tool
extends HBoxContainer

export var enabled := true setget set_enabled
export var selected := false setget set_selected
export var text := "" setget set_text

export var disabled_color := Color.dimgray

	

func _ready():
	set_enabled(enabled)
	pass

func set_enabled(val):
	enabled = val
	if !enabled:
		$text.add_color_override("font_color", disabled_color)
		update()

func set_selected(val):
	selected = val
	if selected:
		$cursor.text = ">"
	else:
		$cursor.text = " "

func set_text(val):
	text = val
	$text.text = val
