extends Object

export (String) var method
export (Array) var params

func trigger():
	callv(method, params)
