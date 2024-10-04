extends Control

func inverse_lerp(a,b,value):
	if a != b:
		return (value -a)/(b-a)
	else:
		return 0.0