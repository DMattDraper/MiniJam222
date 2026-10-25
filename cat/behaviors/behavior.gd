class_name Behavior extends Node

@onready var graphics : Graphics = $Graphics
@onready var room : Room

var active = false

func _ready() -> void:
	room = get_parent()
	room.cat_behavior = self
	
	if graphics != null:
		remove_child(graphics)
		room.add_child.call_deferred(graphics)
		graphics.position = Vector2.ZERO

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
	Statics.hud.update_cat_text("")
