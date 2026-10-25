class_name Pawing extends Behavior

# Pawing behavior one. This will cause the cat to peek into the room and feel around for you with it's paw

var need_to_peek : bool
var peeking : bool

var peeking_timer : Timer
var peeking_wait_time := 5.0

var player_last_position : Vector2

@onready var ray_cast : RayCast2D = $RayCast2D
@onready var paw_holder : Node2D = $Paw_Holder
@onready var anim_player = $Paw_Holder/AnimationPlayer

@onready var arm : MeshInstance2D = $Paw_Holder/Arm_Holder/Arm
@onready var paw : Sprite2D = $Paw_Holder/Paw

@onready var arm_holder : Node2D = $Paw_Holder/Arm_Holder


var origin_point : Node2D

enum DIRECTIONS {
	LEFT,
	RIGHT
}

var direction_of_player : DIRECTIONS

enum STATES {
	IDLE,
	PEEKING,
	PAWING
}

var state : STATES

func _ready() -> void:
	super()
	
	peeking_timer = Timer.new()
	peeking_timer.one_shot = true
	peeking_timer.wait_time = peeking_wait_time
	peeking_timer.timeout.connect(peek_again)
	add_child(peeking_timer)
	
	remove_child(paw_holder)
	room.add_child.call_deferred(paw_holder)
	paw_holder.position.x = -99999
	paw_holder.position.y = -99999
	
	if !find_origin_point():
		push_error("ERROR: Failed to find the origin point for the pawing room")
	else:
		ray_cast.global_position = origin_point.global_position
	
	player_last_position = Vector2.ZERO
	state = STATES.IDLE
	need_to_peek = true
	peeking = false
	ray_cast.enabled = false

func _physics_process(_delta) -> void:
	if state == STATES.PEEKING:
		peek()
	arm_holder.scale.y = abs(paw.global_position.x - origin_point.global_position.x)

func handle_behavior(_delta: float) -> void:
	if need_to_peek and state != STATES.PEEKING:
		state = STATES.PEEKING
		ray_cast.enabled = true

func peek() -> void:
	Statics.hud.update_cat_text("Peeking...")
	ray_cast.target_position = Vector2(cos(Time.get_unix_time_from_system())*(540.0/2.0), sin(Time.get_unix_time_from_system())*(248.0/2.0))
	if ray_cast.is_colliding():
		need_to_peek = false
		peeking_timer.start()
		ray_cast.enabled = false
		player_last_position = ray_cast.get_collision_point()
		paw_holder.position.x = 0
		paw_holder.position.y = 0
		state = STATES.PAWING
		if player_last_position.x < origin_point.global_position.x:
			direction_of_player = DIRECTIONS.LEFT
		else:
			direction_of_player = DIRECTIONS.RIGHT
		paw_at()

func peek_again() -> void:
	player_last_position = Vector2.ZERO
	need_to_peek = true

func paw_at() -> void:
	Statics.hud.update_cat_text("GET BACK!")
	if direction_of_player == DIRECTIONS.LEFT:
		anim_player.play("Attack_Left")
	else:
		anim_player.play("Attack_Right")

func find_origin_point() -> bool:
	for child in get_parent().get_children():
		if child.name == "PawPoint":
			origin_point = child
			return true
	return false

func _on_hurtbox_body_entered(body):
	if body is Player:
		body.kill()
