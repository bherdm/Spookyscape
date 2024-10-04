extends Sprite

export var center = Vector2(0,0)
export var radius = 0.01
export var color = Color(1,0,0)

func _draw():
	draw_circle(center, radius, color)