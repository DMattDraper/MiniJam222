class_name Player extends CharacterBody2D

@onready var player_mover : PlayerMover
@onready var item_holder : ItemHolder
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction := 0.0
var facing := 1.0

func _ready() -> void:
	Statics.player = self

func _process(_delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	
	if direction < 0.0:
		facing = -1.0
		sprite.flip_h = true
	if direction > 0.0:
		facing = 1.0
		sprite.flip_h = false
	
	if Input.is_action_just_pressed("jump"):
		player_mover.jump()
	if Input.is_action_just_released("jump"):
		player_mover.release_jump()
	if Input.is_action_just_pressed("interact"):
		item_holder.interact()
	
	if !is_on_floor():
		if item_holder.held_item != null:
			sprite.play("jump_hold")
		else:
			sprite.play("jump")
	elif direction != 0:
		if item_holder.held_item != null:
			sprite.play("run_hold") 
		else:
			sprite.play("run")
	else:
		if item_holder.held_item != null:
			sprite.play("idle_hold") 
		else:
			sprite.play("idle")
