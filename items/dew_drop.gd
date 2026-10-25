class_name DewDrop extends CharacterBody2D

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_hit_floor := false

@onready var anim_player = $AnimationPlayer

func _process(_delta : float) -> void:
	if is_on_floor() and !has_hit_floor:
		hit_floor()

func _physics_process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	@warning_ignore("return_value_discarded")
	move_and_slide()

func hit_floor() -> void:
	has_hit_floor = true
	anim_player.play("hit_floor")

func delete_self() -> void:
	queue_free()
