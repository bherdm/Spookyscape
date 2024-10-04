extends RigidBody2D

onready var visuals = get_node("Visuals")
onready var broomstick = get_node("BroomstickArea2D")
onready var collisionShape = get_node("CollisionPolygon2D")
onready var particles = get_node("Visuals/Particles2D")

var visual_x_scale = 1

export var h_dir = 0.0
export var v_dir = 0.0

func _ready():
	set_process(true)

func _process(delta):
	#input_to_direction()
	visual_rotation(Vector2(h_dir, v_dir))
	sprite_velocity()

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

export var thrust = 600

func _integrate_forces(state):
	var thrust_boost = 1.0

	var move_velocity = Vector2(h_dir * thrust * thrust_boost, v_dir * thrust * thrust_boost)
	set_applied_force(move_velocity)

func face_leftright():
	visuals.set_scale(Vector2(visual_x_scale,1.0))
	collisionShape.set_scale(Vector2(visual_x_scale,1.0))
	broomstick.set_scale(Vector2(visual_x_scale,1.0))

func set_rotation(rotation):
	visuals.set_rot(rotation)
	collisionShape.set_rot(rotation)
	broomstick.set_rot(rotation)

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
		if (get_linear_velocity().x > 0 && visual_x_scale > 0) || (get_linear_velocity().x < 0 && visual_x_scale < 0): #if facing the direction of velocity
			anim.set_animation("fast")
		else:
			anim.set_animation("backwards") 
	else:
		anim.set_animation("slow")