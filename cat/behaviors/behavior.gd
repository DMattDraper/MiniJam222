class_name Behavior extends Node

@onready var room : Room

var active = false

func _ready() -> void:
	room = get_parent()
	room.cat_behavior = self

func _process(delta: float) -> void:
	if !active:
		return
	handle_behavior(delta)

func handle_behavior(_delta: float) -> void:
	pass

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false
