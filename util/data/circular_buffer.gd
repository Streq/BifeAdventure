class_name CircularBuffer

var buffer : Array= []
var SIZE := 2

var front_index := 0
var end_index := 0

var size = 1
var NULL_VALUE = null

func _init(size: int, null_value = null):
	NULL_VALUE = null_value
	SIZE  = size
	initialize()

func _offset(index, value):
	return (index + (value%SIZE) + SIZE)%SIZE

func _offset_forward(index, positive_value):
	return (index + positive_value)%SIZE

func _decrement(index):
	return (index-1+SIZE)%SIZE 
func _increment(index):
	return (index+1)%SIZE 

func push_back(val):
	end_index = _increment(end_index)
	var deleted = null
	size += 1
	if end_index == front_index:
		size = SIZE
		front_index = _increment(front_index)
		deleted = buffer[end_index]
	buffer[end_index] = val
	return deleted

func push_front(val):
	front_index = _decrement(front_index)
	var deleted = null
	size += 1
	if end_index == front_index:
		size = SIZE
		end_index = _decrement(end_index)
		deleted = buffer[front_index]
	buffer[front_index] = val
	return deleted

func pop_back():
	if size==1:
		return null
	size -= 1
	var deleted = buffer[end_index]
	buffer[end_index] = null
	end_index = _decrement(end_index)
	return deleted

func pop_front():
	if size==1:
		return null
	size -= 1
	var deleted = buffer[front_index]
	buffer[front_index] = null
	front_index = _increment(front_index)
	return deleted

func at(index):
	if index >= 0 and size > index:
		index = (front_index + index)%SIZE
	elif index < 0 and size >= -index:
		index = (end_index + index+1 + SIZE)%SIZE
	else:
		return null
	return buffer[index]

func clear():
	buffer.clear()
	initialize()

func initialize():
	size = 1
	front_index = SIZE/2
	end_index = SIZE/2
	buffer.resize(SIZE)
	buffer[front_index] = NULL_VALUE
