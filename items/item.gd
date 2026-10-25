class_name Item extends CharacterBody2D

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var stop_drag := 0.025
@export var air_drag = 0.1

@export var interaction_message := "Press E to Pickup"
@export var item_name := "Item"
@export var reset_on_death := false
var held := false

var move_drag := 0.0

var starting_position : Vector2

func _ready() -> void:
	starting_position = position

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

func grab() -> void:
	pass

func drop() -> void:
	pass

func reset() -> void:
	position = starting_position
