class_name PlayerMover extends Node

@export var jump_force := -400
@export var max_speed := 200.0
@export var move_accel := 10.0
@export var stop_drag := 0.1
@export var air_drag = 0.1

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

var body : Player
var move_drag := 0.0

func _ready() -> void:
	body = get_parent()
	body.player_mover = self
	move_drag = move_accel / max_speed

func jump() -> float:
	if body.is_on_floor():
		body.velocity.y = jump_force
		return jump_force
	return 0.0

func release_jump() -> float:
	if body.velocity.y < 0.0:
		body.velocity.y *= 0.5
		return body.velocity.y
	return 0.0

func _physics_process(delta: float) -> void:
	
	# Apply Gravity
	if not body.is_on_floor():
		var applied_gravity := gravity * delta
		if body.velocity.y > 0 and body.item_holder.held_item is Feather:
			applied_gravity *= 0.25
		body.velocity.y += applied_gravity
	
	# Calculate Drag
	var drag := move_drag
	if body.direction == 0.0:
		drag = stop_drag
		if not body.is_on_floor():
			drag *= air_drag
	
	# Calculate Velocity
	var flat_velo := body.velocity.x
	body.velocity.x += move_accel * body.direction - flat_velo * drag
	
	body.move_and_slide()
