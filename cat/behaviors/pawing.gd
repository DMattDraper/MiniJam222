class_name Pawing extends Behavior

# Pawing behavior one. This will cause the cat to peek into the room and feel around for you with it's paw

var need_to_peek : bool
var peeking : bool

var peeking_timer : Timer
var peeking_wait_time := 5.0

var player_last_position : Vector2

@onready var ray_cast : RayCast2D = $RayCast2D
@onready var paw : Node2D = $Paw

var origin_point : Node2D

func _ready() -> void:
	super()
	
	peeking_timer = Timer.new()
	peeking_timer.one_shot = true
	peeking_timer.wait_time = peeking_wait_time
	peeking_timer.timeout.connect(peek_again)
	add_child(peeking_timer)
	
	if !find_origin_point():
		push_error("ERROR: Failed to find the origin point for the pawing room")
	else:
		ray_cast.global_position = origin_point.global_position
	
	player_last_position = Vector2.ZERO
	need_to_peek = true
	peeking = false
	ray_cast.enabled = false
	paw.global_position = Vector2(-99999,-99999)

func _physics_process(_delta) -> void:
	if peeking:
		peek()
	elif player_last_position != Vector2.ZERO:
		paw_at()

func handle_behavior() -> void:
	if need_to_peek and !peeking:
		peeking = true
		ray_cast.enabled = true

func peek() -> void:
	ray_cast.target_position = Vector2(cos(Time.get_unix_time_from_system())*(480.0/2.0), sin(Time.get_unix_time_from_system())*(248.0/2.0))
	if ray_cast.is_colliding():
		need_to_peek = false
		peeking = false
		peeking_timer.start()
		ray_cast.enabled = false
		player_last_position = ray_cast.get_collision_point()
		paw.global_position = origin_point.global_position

func peek_again() -> void:
	player_last_position = Vector2.ZERO
	need_to_peek = true

func paw_at() -> void:
	paw.global_position = paw.global_position.lerp(player_last_position, 0.05)
	print(rad_to_deg(origin_point.global_position.normalized().angle_to(player_last_position.normalized())))

func find_origin_point() -> bool:
	for child in get_parent().get_children():
		if child.name == "PawPoint":
			origin_point = child
			return true
	return false
