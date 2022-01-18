extends Node

func process(text: String, width: int, lines: int) -> PoolStringArray:
	var end := text.length()
	if width > end:
		return PoolStringArray([text])
	var ret = PoolStringArray()
	var current_panel = ""
	var length_of_current_line := 0
	var start_of_current_line := 0
	var line := 0
	var top := 0
	while start_of_current_line != end:
		top = min(end-start_of_current_line, width)
		length_of_current_line = top
		while text[start_of_current_line + length_of_current_line - 1] != ' ' and length_of_current_line != 0 and top == width:
			length_of_current_line -= 1
		if length_of_current_line == 0:
			length_of_current_line = top
		current_panel += text.substr(start_of_current_line, length_of_current_line)
		start_of_current_line += length_of_current_line
		line += 1
		if line == lines or start_of_current_line == end:
			line = 0
			ret.append(current_panel)
			current_panel = ""
		else:
			current_panel += '\n'
	return ret
