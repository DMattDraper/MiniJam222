class_name World extends Node

@onready var camera: Camera2D = $Camera2D

@onready var current_room : Room
@onready var next_room : Room

var rooms : Array[Room] = []

func _ready() -> void:
	Statics.world = self
	
	var items = get_tree().get_nodes_in_group("rooms")
	for item in items:
		if item is Room:
			rooms.push_back(item)
			item.room_entered.connect(room_entered)
			item.room_exited.connect(room_exited)
			if item.starting_room:
				current_room = item

func room_entered(room: Room) -> void:
	next_room = room

func room_exited(room: Room) -> void:
	if room == next_room:
		next_room = null
	if room == current_room and next_room:
		change_room()

func change_room() -> void:
	current_room.deactivate()
	current_room = next_room
	next_room = null
	current_room.activate()
	
	camera.global_position = current_room.camera_anchor.global_position

func get_room_by_index(x: int, y: int) -> Room:
	for room in rooms:
		if x == room.index_x and y == room.index_y:
			return room
	return null
