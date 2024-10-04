extends Camera2D

export var move_right_speed = 200.0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	set_pos(Vector2(get_pos().x + move_right_speed * delta, get_pos().y))
