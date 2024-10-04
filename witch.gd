extends Node2D

onready var visuals = get_node("Visuals")
onready var broomstick = get_node("BroomstickArea2D")
onready var witch_hitbox = get_node("WitchArea2D")
#onready var collisionShape = get_node("CollisionPolygon2D")
onready var particles = get_node("Visuals/Particles2D")

var visual_x_scale = 1
var v_dir = 0.0
var h_dir = 0.0
var friction = 3.0
var linear_velocity = Vector2(0.0,0.0)
var min_y = -850.0
var max_y = 500.0
export var thrust = 600
var acceleration = 10.0
var max_thrust = 750.0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	input_to_direction()
	visual_rotation(Vector2(h_dir, v_dir))
	sprite_velocity()
	integrate_forces(delta)

func input_to_direction():
	v_dir = 0.0
	h_dir = 0.0
	if Input.is_action_pressed("move_right"):
		h_dir += 1.0
		if visual_x_scale < 0.0:
			visual_x_scale = 1.0
			face_leftright()
	if Input.is_action_pressed("move_left"):
		h_dir -= 1.0
		if visual_x_scale > 0.0:
			visual_x_scale = -1.0
			face_leftright()
	if Input.is_action_pressed("move_up"):
		v_dir -= 1.0
	if Input.is_action_pressed("move_down"):
		v_dir += 1.0

func die():
	App_SceneLoader.current_stage_manager.game_over()
	#queue_free()



func get_linear_velocity():
	return linear_velocity

func integrate_forces(delta):	
	if h_dir != 0:
		linear_velocity.x = clamp(linear_velocity.x + (h_dir * acceleration), -max_thrust, max_thrust)
	else:
		if linear_velocity.x > friction:
			linear_velocity.x -= friction
		elif linear_velocity.x < -friction:
			linear_velocity.x += friction
		else:
			linear_velocity.x = 0.0
	
	
	if v_dir != 0:
		linear_velocity.y = clamp(linear_velocity.y + v_dir * acceleration, -max_thrust, max_thrust)
	else:
		if linear_velocity.y > friction:
			linear_velocity.y -= friction
		elif linear_velocity.y < -friction:
			linear_velocity.y += friction
		else:
			linear_velocity.y = 0.0
		linear_velocity.y
	
	var new_X_position = get_pos().x + linear_velocity.x * delta
	var new_Y_position = get_pos().y + linear_velocity.y * delta
	if new_Y_position <= min_y:
		new_Y_position = min_y
		linear_velocity.y = 0
	elif new_Y_position >= max_y:
		new_Y_position = max_y
		linear_velocity.y = 0
	
	set_pos(Vector2(new_X_position,new_Y_position))

func face_leftright():
	visuals.set_scale(Vector2(visual_x_scale,1.0))
	#collisionShape.set_scale(Vector2(visual_x_scale,1.0))
	broomstick.set_scale(Vector2(visual_x_scale,1.0))
	witch_hitbox.set_scale(Vector2(visual_x_scale,1.0))
func set_rotation(rotation):
	visuals.set_rot(rotation)
	#collisionShape.set_rot(rotation)
	broomstick.set_rot(rotation)
	witch_hitbox.set_rot(rotation)

func visual_rotation(direction):
	direction = direction.normalized()
	var rotation = direction.angle()
	
	if direction.x == 0.0 && direction.y == 0.0:
		set_rotation(rotation)
		particles.set_emitting(false)
	else:
		if visual_x_scale > 0:
			set_rotation(rotation - 2)
		elif visual_x_scale < 0:
			set_rotation(rotation + 2)
		particles.set_emitting(true)

var sprite_fast_minimum = 350.0
onready var anim = get_node("Visuals/AnimatedSprite")
func sprite_velocity():
	var x_vel = get_linear_velocity().x
	var y_vel = get_linear_velocity().y
	
	var going_fast = false
	if (abs(x_vel) > sprite_fast_minimum || abs(y_vel) > sprite_fast_minimum):
		going_fast = true
	
	if going_fast == true:
		if (x_vel > 0 && visual_x_scale > 0) || (x_vel < 0 && visual_x_scale < 0): #if facing the direction of velocity.x
			anim.set_animation("fast")
		elif (x_vel == 0 && ((y_vel < 0 && v_dir < 0) || (y_vel > 0 && v_dir > 0))): #if going fast, but not on x, and facing the direction input is pointing
			anim.set_animation("fast")
		else:
			anim.set_animation("backwards") 
	else:
		anim.set_animation("slow")

func _on_WitchArea2D_area_enter( area ):
	if area.get_parent().has_method("whacked"):
		if area.get_parent().dying == false:
			die()
