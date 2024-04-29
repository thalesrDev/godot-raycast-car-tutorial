extends RigidBody3D

@export var suspension_rest_dist: float = 0.5
@export var spring_strength: float = 10
@export var spring_damper: float = 1
@export var wheel_radius: float = 0.33

@export var debug: bool = false
@export var engine_power: float

var accel_input

@export var steering_angle: float = 30.0
@export var front_tire_grip: float = 2.0
@export var rear_tire_grip: float = 2.0

var steering_input

func _process(delta):
	accel_input = Input.get_axis("reverse", "accelerate")
	
	steering_input = Input.get_axis("turn_right", "turn_left")
	var steering_rotation = steering_input * steering_angle
	
	var fl_wheel = $Wheels/FL_Wheel
	var fr_wheel = $Wheels/FR_Wheel
	
	if steering_rotation != 0:
		var angle = clamp(fl_wheel.rotation.y + steering_rotation, -steering_angle, steering_angle)
		var new_rotation = angle * delta
		
		fl_wheel.rotation.y = lerp(fl_wheel.rotation.y, new_rotation, 0.3)
		fr_wheel.rotation.y = lerp(fr_wheel.rotation.y, new_rotation, 0.3)
	else:
		fl_wheel.rotation.y = lerp(fl_wheel.rotation.y, 0.0, 0.2)
		fr_wheel.rotation.y = lerp(fr_wheel.rotation.y, 0.0, 0.2)
