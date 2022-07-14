extends Node2D
export var buffer_size := 10

var buffer : CircularBuffer

export var BOX : PackedScene
export var radius := 100.0


onready var center = $center


func _ready():
	buffer = CircularBuffer.new(buffer_size, Color.white)

	update_display()

var increments = 10
var current_color = 10
func new_color():
	current_color += increments
	current_color %= 256
	return Color8(current_color,randi()%256,256-current_color)
	
func get_box(index):
	pass

func _input(event):
	var u = false
	if event.is_action_pressed("right0"):
		buffer.push_back(new_color())
		u = true
	elif event.is_action_pressed("left0"):
		buffer.pop_back()
		u = true
	elif event.is_action_pressed("down0"):
		buffer.push_front(new_color())
		u = true
	elif event.is_action_pressed("up0"):
		buffer.pop_front()
		u = true
	
	if u:
		update_display()

func update_display():
	for child in center.get_children():
		center.remove_child(child)
	var angle_unit = TAU/buffer.SIZE
	for i in buffer.SIZE:
		if buffer.buffer[i]:
			var box = BOX.instance()
			center.add_child(box)
			box.position = Vector2.RIGHT.rotated(angle_unit*i) * radius
			box.modulate = buffer.buffer[i]
	if true:
		var box = BOX.instance()
		center.add_child(box)
		box.position = Vector2.RIGHT.rotated(angle_unit*buffer.front_index) * (radius + 20)
		box.modulate = Color.green
	if true:
		var box = BOX.instance()
		center.add_child(box)
		box.position = Vector2.RIGHT.rotated(angle_unit*buffer.end_index) * (radius + 20)
		box.modulate = Color.red
	for i in buffer.size:
		var label = Label.new()
		var node = Node2D.new()
		center.add_child(node)
		node.position = Vector2.RIGHT.rotated(angle_unit*(buffer.front_index+i)) * (radius + 20)
		node.add_child(label)
		label.text = str(i)
func _on_get_index_text_entered(new_text):
	var index = int(new_text)
	var color = buffer.at(index)
	$box.modulate = color if color else Color.black
	
