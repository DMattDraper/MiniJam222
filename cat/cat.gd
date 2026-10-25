class_name Cat extends Node

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
@export var distract_time := 30.0

var patience := 0
@export var search_patience := 3
@export var hunt_patience := 5

var timer : Timer

func _ready() -> void:
	Statics.cat = self
	
	timer = Timer.new()
	timer.wait_time = wander_time
	timer.timeout.connect(process_state)
	add_child(timer)
	timer.start()

func _process(_delta: float) -> void:
	if current_room == null:
		var rooms := Statics.world.rooms
		var i := randi_range(0, rooms.size() - 1)
		
		current_room = rooms[i]
		current_room.is_cat_present = true

func change_state(new_state: STATES) -> void:
	if state == STATES.ATTACKING and new_state != STATES.DISTRACTED:
		current_room.deactivate()
	
	state = new_state
	match (state):
		STATES.WANDERING:
			timer.wait_time = wander_time
			timer.start()
		STATES.SEARCHING:
			timer.wait_time = search_time
			timer.start()
			patience = search_patience
		STATES.HUNTING:
			timer.wait_time = hunt_time
			timer.start()
			patience = hunt_patience
		STATES.ATTACKING:
			current_room.activate()
		STATES.DISTRACTED:
			timer.wait_time = distract_time
			timer.start()

func process_state() -> void:
	if current_room == Statics.world.current_room:
		match (state):
			STATES.WANDERING:
				change_state(STATES.SEARCHING)
			STATES.SEARCHING:
				change_state(STATES.HUNTING)
			STATES.HUNTING:
				change_state(STATES.ATTACKING)
			STATES.ATTACKING:
				pass
			STATES.DISTRACTED:
				change_state(STATES.WANDERING)
	else:
		if state == STATES.ATTACKING:
			change_state(STATES.HUNTING)
		elif state == STATES.DISTRACTED:
			change_state(STATES.WANDERING)
		else:
			change_room()

func change_room() -> void:
	var next_room = null
	
	if patience > 0:
		patience -= 1
		if patience == 0:
			match (state):
				STATES.SEARCHING:
					change_state(STATES.WANDERING)
				STATES.HUNTING:
					change_state(STATES.SEARCHING)
	
	while(next_room == null):
		var x := randi_range(-1, 1)
		var y := randi_range(-1, 1)
		
		if state == STATES.WANDERING or state == STATES.SEARCHING:
			next_room = Statics.world.get_room_by_index(current_room.index_x + x, current_room.index_y + y)
		if state == STATES.HUNTING:
			var x_offset =  clamp(Statics.world.current_room.index_x - current_room.index_x, -1, 1)
			var y_offset =  clamp(Statics.world.current_room.index_y - current_room.index_y, -1, 1)
			next_room = Statics.world.get_room_by_index(current_room.index_x + x_offset, current_room.index_y + y_offset)
			if next_room == null:
				next_room = Statics.world.get_room_by_index(current_room.index_x + x, current_room.index_y + y)
	
	current_room.is_cat_present = false
	
	next_room.is_cat_present = true
	
	current_room = next_room
	
	Statics.debug.set_cat_state_label("%s, %s" % [current_room.index_x, current_room.index_y])

func play_alert_sound() -> void:
	$AlertSound.play()
