class_name Mouse extends CharacterBody2D

@onready var butt: CharacterBody2D = $Butt
@onready var sprite: AnimatedSprite2D = $Sprite

@export var flipped := false
@export var max_speed := 500.0
@export var move_accel := 10.0
@export var stop_drag := 0.1
var direction = 0.0

var move_drag := 0.0

func _ready() -> void:
	move_drag = move_accel / max_speed
	if flipped:
		butt.position.x *= -1

func _physics_process(_delta: float) -> void:
	# Calculate Drag
	var drag := move_drag
	
	# Calculate Velocity
	var flat_velo := velocity.x
	velocity.x += move_accel * direction - flat_velo * drag
	
	move_and_slide()

func scare():
	sprite.play("run")
	$SqueakSound.play()
	collision_layer = 0
	direction = -1.0
	if (flipped):
		direction = 1.0
	await get_tree().create_timer(3.0).timeout
	queue_free()
