class_name Room extends Node2D

@onready var camera_anchor: Marker2D = $CameraAnchor
@onready var bounding_box: Area2D = $BoundingBox

@export var starting_room := false

var index_x := 0
var index_y := 0

signal room_entered(room: Room)
signal room_exited(room: Room)

func _ready() -> void:
	index_x = position.x / Statics.game_screen_width
	index_y = position.y / Statics.game_screen_height

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		room_entered.emit(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		room_exited.emit(self)
