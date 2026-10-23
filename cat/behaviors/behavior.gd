class_name Behavior extends Node

@onready var room : Room

var active = false

func _ready() -> void:
	room = get_parent()
	room.cat_behavior = self
