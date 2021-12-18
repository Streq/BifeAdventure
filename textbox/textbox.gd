extends CanvasLayer

"""
TextBox HUD, works perfectly for chaining short messages.
Can't handle long messages given it lacks context regarding length of visible
characters
"""

signal text_display_started(textbox)
signal text_display_finished(textbox)
signal text_panel_started(textbox)
signal text_panel_finished(textbox)

export var CHAR_READ_RATE := 0.01
enum State {
	READY,
	READING,
	FINISHED
}


export (int) var max_lines
onready var textbox_container = $textbox_container
onready var start_symbol = $textbox_container/margin_container/hbox_container/start
onready var end_symbol = $textbox_container/margin_container/hbox_container/end
onready var label = $textbox_container/margin_container/hbox_container/label
onready var panel_length = label.text.length()


var current_state = State.READY
var text_queue = []

func _ready():
	print_debug("start State.READY")
	label.max_lines_visible = max_lines
	hide_textbox()
	return


func _process(delta):
	match current_state:
		State.READY:
			if max_lines > 0 and label.get_line_count() - label.lines_skipped > max_lines:
				start_symbol.text = ""
				label.lines_skipped += max_lines
				change_state(State.READING)
				tween_text()
			elif !text_queue.empty():
				display_text()
			elif textbox_container.visible:
				hide_textbox()
		State.READING:
#			print_debug(label.percent_visible)
			if Input.is_action_just_pressed("A0"):
				end_tween_early()
		State.FINISHED:
			if Input.is_action_just_pressed("A0"):
				change_state(State.READY)
		
"""
add some text of arbitrary length.
if the text is several panels long we want to separate it into smaller texts 
that fit into the panel and queue those.
the thing is that wordwrap doesn't give us a consistent length, different
texts with the same character length can take up a different amount of lines
"""
func add_text(text: String):
	print_debug("adding: "+text)
	text_queue.push_back(text)

func add_texts(texts):
	for text in texts:
		add_text(text)

func hide_textbox():
	emit_signal("text_display_finished", self)
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	if !textbox_container.visible:
		emit_signal("text_display_started", self)
	
	emit_signal("text_panel_started", self)
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.lines_skipped = 0
	change_state(State.READING)
	show_textbox()
	tween_text()



func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print_debug("Changing state to: State.READY")
			pass
		State.READING:
			print_debug("Changing state to: State.READING")
			pass
		State.FINISHED:
			print_debug("Changing state to: State.FINISHED")
			pass

func tween_text():
	label.percent_visible = 0
	end_symbol.text = ""
	$tween.interpolate_property(label, "percent_visible", 0.0, 1.0, CHAR_READ_RATE * label.text.length(), Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$tween.start()
#	end_tween_early()

func end_tween_early():
	$tween.remove_all()
	label.percent_visible = 1.0
	finished_reading()

func _on_Tween_tween_completed(object, key):
	finished_reading()

func finished_reading():
	emit_signal("text_panel_finished", self)
	end_symbol.text = "v" if !text_queue.empty() or (label.get_line_count() - label.lines_skipped > max_lines) else ""
	change_state(State.FINISHED)
