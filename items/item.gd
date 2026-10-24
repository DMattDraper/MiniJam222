class_name Item extends CharacterBody2D

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var stop_drag := 0.025
@export var air_drag = 0.1

var held := false

var move_drag := 0.0

func _physics_process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor() and not held:
		velocity.y += gravity * delta
	
	# Calculate Drag
	var drag := move_drag
	drag = stop_drag
	if not is_on_floor():
		drag *= air_drag
	
	# Calculate Velocity
	var flat_velo := velocity.x
	velocity.x -= flat_velo * drag
	
	@warning_ignore("return_value_discarded")
	move_and_slide()
