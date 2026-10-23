class_name Behavior extends Node

@onready var room : Room

var active = false

func _ready() -> void:
	room = get_parent()
	room.cat_behavior = self

func _process(_delta: float) -> void:
	if !active:
		return
	handle_behavior()

func handle_behavior() -> void:
	pass

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false
