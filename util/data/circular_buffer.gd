class_name CircularBuffer

var buffer := []
var SIZE := 0

var front_index := 0
var end_index := 0

var size = 1

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
	assert(end_index != front_index, "the circular buffer cannot decrease in size as it has the minimum amount of elements(1)")
	size -= 1
	var deleted = buffer[end_index]
	end_index = _decrement(end_index)
	return deleted

func pop_front():
	assert(end_index != front_index, "the circular buffer cannot decrease in size as it has the minimum amount of elements(1)")
	size -= 1
	var deleted = buffer[front_index]
	front_index = _increment(end_index)
	return deleted

func get(index):
	index = index%SIZE
	if index >= 0:
		return buffer[(front_index + index)%SIZE]
	else:
		return buffer[(end_index - index+1 + SIZE)%SIZE]
func clear(starter_val = null):
	size = 1
	buffer.clear()
	front_index = SIZE/2
	end_index = SIZE/2
	buffer.resize(SIZE)
	buffer[front_index] = starter_val
	
