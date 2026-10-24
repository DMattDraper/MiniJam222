extends Behavior

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var timer : Timer
@export var wait_time := 5.0
@export var speed = 5.0

var seeking = false

func _ready() -> void:
	super()
	
	remove_child(ray_cast)
	room.add_child.call_deferred(ray_cast)
	ray_cast.position = Vector2.ZERO
	
	timer = Timer.new()
	timer.wait_time = wait_time
	timer.timeout.connect(start_seek)
	add_child(timer)

func activate() -> void:
	super()
	timer.start()

func deactivate() -> void:
	super()
	timer.stop()

func handle_behavior(_delta: float) -> void:
	if seeking:
		var target = ray_cast.get_collider()
		if target != null and target is Player:
			GameManager.reset()
		
		ray_cast.position.x -= 5
		if ray_cast.position.x == Statics.game_screen_width / -2.0:
			stop_seek()

func start_seek() -> void:
	seeking = true
	ray_cast.position.x = Statics.game_screen_width / 2.0

func stop_seek() -> void:
	seeking = false
