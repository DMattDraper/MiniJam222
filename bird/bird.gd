class_name bird extends Node2D

var room : Room
@onready var worm_scanner : CollisionShape2D = $WormScanner/CollisionShape2D
var feather_scene = preload("res://items/feather.tscn")

var timer : Timer
var wait_time := 2.5
var timer_started : bool

var worm_in_room : bool

var worm : Worm

func _ready() -> void:
	room = get_parent()
	worm_scanner.global_position = room.global_position
	worm_scanner.shape.extents = Vector2(480, 270)
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = wait_time
	timer.one_shot = true
	timer.timeout.connect(fly_into_room)
	
	timer_started = false
	worm_in_room = false

func _process(_delta: float) -> void:
	if worm_in_room and Statics.world.current_room != room and !timer_started:
		timer_started = true
		timer.start()
	elif worm_in_room and Statics.world.current_room == room:
		if timer_started:
			timer.stop()
		timer_started = false

func fly_into_room() -> void:
	spawn_feather()
	eat_worm()
	Statics.hud.update_message_text("A good trade!")

func spawn_feather() -> void:
	var feather_inst = feather_scene.instantiate()
	add_sibling(feather_inst)
	feather_inst.global_position = room.global_position

func eat_worm() -> void:
	if worm != null and worm.has_method("queue_free"):
		worm.queue_free()
	worm_in_room = false

func _on_worm_scanner_body_entered(body):
	if body is Worm:
		worm_in_room = true
		worm = body

func _on_worm_scanner_body_exited(body):
	if body is Worm:
		worm_in_room = false
		worm = null
