class_name Cat extends Node

# TODO: Remove, temporary
const BLACK_CAT = preload("res://cat/black_cat.png")

enum STATES {
	WANDERING,
	SEARCHING,
	HUNTING,
	ATTACKING,
	DISTRACTED
}

var state : STATES = STATES.WANDERING

@onready var current_room : Room

@export var wander_time := 10.0
@export var search_time := 5.0
@export var hunt_time := 2.5
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = wander_time
	timer.timeout.connect(change_room)
	add_child(timer)
	timer.start()

func _process(_delta: float) -> void:
	if current_room == null:
		var rooms := Statics.world.rooms
		var i := randi_range(0, rooms.size() - 1)
		
		current_room = rooms[i]
		current_room.is_cat_present = true
		current_room.background.texture = BLACK_CAT

func change_state(new_state: STATES) -> void:
	state = new_state
	Statics.debug.set_cat_state_label(STATES.find_key(state))
	match (state):
		STATES.WANDERING:
			timer.wait_time = wander_time
			timer.start()
		STATES.SEARCHING:
			timer.wait_time = search_time
			timer.start()
		STATES.HUNTING:
			timer.wait_time = hunt_time
			timer.start()
		STATES.ATTACKING:
			# TODO: Remove, temporary
			Statics.player.queue_free()
			await get_tree().create_timer(2.0).timeout
			GameManager.reset()
		STATES.DISTRACTED:
			pass
	
func change_room() -> void:
	if current_room == Statics.world.current_room:
		match (state):
			STATES.WANDERING:
				change_state(STATES.SEARCHING)
			STATES.SEARCHING:
				change_state(STATES.HUNTING)
			STATES.HUNTING:
				change_state(STATES.ATTACKING)
		return
	
	var next_room = null
	
	while(next_room == null):
		var x := randi_range(-1, 1)
		var y := randi_range(-1, 1)
		
		next_room = Statics.world.get_room_by_index(current_room.index_x + x, current_room.index_y + y)
	
	current_room.is_cat_present = false
	current_room.background.texture = null
	
	next_room.is_cat_present = true
	next_room.background.texture = BLACK_CAT
	
	current_room = next_room
	current_room.meow.play()
