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
	graphics.play("patrol")

func deactivate() -> void:
	super()
	timer.stop()
	Statics.hud.update_cat_text("")
	graphics.stop()

func handle_behavior(_delta: float) -> void:
	if seeking:
		var target = ray_cast.get_collider()
		if target != null and target is Player:
			target.kill()
		
		ray_cast.position.x -= 5
		if ray_cast.position.x == Statics.game_screen_width / -2.0:
			stop_seek()
	else:
		var num_periods : int = abs(timer.time_left - wait_time)
		var warning_string := "Hide"
		for i in range(num_periods):
			warning_string += "."
		Statics.hud.update_cat_text(warning_string)

func start_seek() -> void:
	seeking = true
	ray_cast.position.x = Statics.game_screen_width / 2.0
	Statics.hud.update_cat_text("DON'T MOVE!")
	graphics.play("attack")
	$SnarlSound.play()

func stop_seek() -> void:
	seeking = false
	graphics.play("patrol")
