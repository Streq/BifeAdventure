extends Node2D
export var buffer_size := 10

var buffer : CircularBuffer

export var BOX : PackedScene
export var LABEL : PackedScene
export var radius := 100.0


onready var center = $center


func _ready():
	buffer = CircularBuffer.new(buffer_size, BOX.instance())

	update_display()

var increments = 10
var current_color = 10
var alt = false
func new_color():
	current_color += increments
	current_color %= 256
	var color = (current_color + (100 if alt else 0))%256
	alt = !alt
	
	var ret = BOX.instance()
	ret.modulate = Color8(color,randi()%256,256-color)
	return ret
	
func get_box(index):
	pass

var right = false
var left = false
var down = false
var up = false

func _process(delta):
	var u = false
	var deleted = null
	if right:
		deleted = buffer.push_back(new_color())
		delete(deleted)
		u = true
	if left:
		deleted = buffer.pop_back()
		delete(deleted)
		u = true
	if down:
		deleted = buffer.push_front(new_color())
		delete(deleted)
		u = true
	if up:
		deleted = buffer.pop_front()
		delete(deleted)
		u = true
	
	if u:
		update_display()

func delete(deleted:Node):
	if is_instance_valid(deleted):
		if deleted.is_inside_tree():
			var t = deleted.global_transform
			center.remove_child(deleted)
			get_tree().current_scene.add_child(deleted)
			deleted.global_transform = t
			deleted.die()

func _input(event):
	if event.is_action("right0"):
		right = event.is_pressed()
	elif event.is_action("left0"):
		left = event.is_pressed()
	elif event.is_action("down0"):
		down = event.is_pressed()
	elif event.is_action("up0"):
		up = event.is_pressed()
		
	var deleted = null
	var u = false
	
	if event.is_action_pressed("right1"):
		deleted = buffer.push_back(new_color())
		delete(deleted)
		u = true
		
	elif event.is_action_pressed("left1"):
		deleted = buffer.pop_back()
		delete(deleted)
		u = true
	
	elif event.is_action_pressed("down1"):
		deleted = buffer.push_front(new_color())
		delete(deleted)
		u = true
	
	elif event.is_action_pressed("up1"):
		deleted = buffer.pop_front()
		delete(deleted)
		u = true
	if u:
		update_display()
	

func update_display():
	for child in center.get_children():
		center.remove_child(child)
	var angle_unit = TAU/buffer.SIZE
	for i in buffer.SIZE:
		if buffer.buffer[i]:
			var box = buffer.buffer[i]
			box.position = Vector2.RIGHT.rotated(angle_unit*i) * radius
			center.add_child(box)
	if true:
		var box = BOX.instance()
		center.add_child(box)
		box.position = Vector2.RIGHT.rotated(angle_unit*buffer.front_index) * (radius + 20)
		box.modulate = Color.darkgreen
	if true:
		var box = BOX.instance()
		center.add_child(box)
		box.position = Vector2.RIGHT.rotated(angle_unit*buffer.end_index) * (radius + 20)
		box.modulate = Color.darkred
	for i in buffer.size:
		var label = LABEL.instance()
		var node = Node2D.new()
		center.add_child(node)
		node.position = Vector2.RIGHT.rotated(angle_unit*(buffer.front_index+i)) * (radius + 20)
		node.add_child(label)
		label.text = str(i)



func _on_size_text_entered(new_text):
	buffer.resize(int(clamp(int(new_text),1,100)))
	update_display()


func _on_clear_pressed():
	buffer.clear()
	update_display()


func _on_get_text_entered(new_text):
	var index = int(new_text)
	var color = buffer.at(index)
	$box.modulate = color.modulate if color else Color.black

