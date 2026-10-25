class_name DewDropSpawner extends Node2D

var dew_drop_scene = preload("res://items/dew_drop.tscn")

var spawn_timer : Timer
var spawn_time := 3.0

func _ready() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = spawn_time
	spawn_timer.timeout.connect(spawn_dew_drop)
	spawn_timer.start()

func spawn_dew_drop() -> void:
	var dew_drop_inst = dew_drop_scene.instantiate()
	add_child(dew_drop_inst)
	dew_drop_inst.global_position = global_position
