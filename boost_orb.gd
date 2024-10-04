extends Area2D

onready var particles_array = [get_node("Particles2D"), get_node("Particles2D1")]

#var witch_in_area = false

var start_orbit_velocity
var start_linear_velocity
var start_half_extents
var start_initial_size
var start_pos

var target_orbit_velocity = 10
var target_linear_velocity = 5
var target_half_extents = Vector2(5.0,5.0)
var target_initial_size = 4.0

export var time_to_target = 5.0
var time_remaining

var player

func _ready():
	start_orbit_velocity = particles_array[0].get_param(4) #PARAM_ORBIT_VELOCITY
	start_linear_velocity = particles_array[0].get_param(2) #PARAM_LINEAR_VELOCITY
	start_half_extents = particles_array[0].get_emission_half_extents()
	start_initial_size = particles_array[0].get_param(11) #PARAM_INITIAL_SIZE
	start_pos = get_global_pos()
	
	time_remaining = time_to_target

func _fixed_process(delta):
	if time_remaining > 0:
		#if Input.is_action_pressed("move_faster"):
		time_remaining -= delta
		
		var time_lerp = extended_func.inverse_lerp(time_to_target, 0.0, time_remaining)
		
		for particles in particles_array:
			
			#Set Linear Velocity
			particles.set_param(2, lerp(start_linear_velocity, target_linear_velocity, time_lerp))
			
			#Set Orbit Velocity
			particles.set_param(4, lerp(start_orbit_velocity, target_orbit_velocity, time_lerp))
			
			#Set Half Extents
			particles.set_emission_half_extents(Vector2(lerp(start_half_extents.x, target_half_extents.x, time_lerp), lerp(start_half_extents.y, target_half_extents.y, time_lerp)))
			
			#Set Initial Size
			particles.set_param(11, lerp(start_initial_size, target_initial_size, time_lerp))
			
			#Move toward player
		var move_time_lerp = clamp(time_lerp * 8,0.0,1.0)
		var lerp_x = lerp(start_pos.x, player.get_global_pos().x, move_time_lerp)
		var lerp_y = lerp(start_pos.y, player.get_global_pos().y, move_time_lerp)
		set_global_pos(Vector2(lerp_x, lerp_y))
		player.thrust_boost = player.thrust_boost + (2*delta)

func _on_Boost_Orb_body_enter( body ):
	if body.get_name() == "witch":
		#witch_in_area = true
		player = body
		set_fixed_process(true)

func _on_Boost_Orb_body_exit( body ):
	if body.get_name() == "witch":
		#witch_in_area = false
		set_fixed_process(false)
