class_name Player extends CharacterBody2D

@onready var player_mover : PlayerMover

var direction := 0.0

func _process(_delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("jump"):
		player_mover.jump()
	if Input.is_action_just_released("jump"):
		player_mover.release_jump()
