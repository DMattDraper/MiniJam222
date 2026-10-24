class_name ItemHolder extends Node2D

var body : Player
@onready var ray: RayCast2D = $RayCast2D

@export var pickup_range = 24.0

var held_item = null

func _ready() -> void:
	body = get_parent()
	body.item_holder = self

func _process(_delta: float) -> void:
	ray.target_position.x = body.facing * pickup_range
	
	if held_item != null:
		held_item.global_position = lerp(held_item.global_position, global_position, 1.0)
	
	var target = ray.get_collider()
	
	if target != null and target is Interactable:
		Statics.hud.update_interaction_text(target.interaction_message)
	elif target != null and target is Item and held_item == null:
		Statics.hud.update_interaction_text(target.interaction_message)
	else:
		Statics.hud.update_interaction_text("")

func interact() -> void:
	var target = ray.get_collider()
	
	if target != null and target is Interactable:
		if target is Cauldron:
			if (target.interact(held_item)): destroy()
			return
		target.interact(held_item)
		return
	
	if held_item != null:
		drop()
		return
	
	if target != null and target is Item:
		pickup(target)

func pickup(target: Item) -> void:
	held_item = target
	held_item.grab()
	held_item.held = true
	held_item.z_index += 1

func drop() -> void:
	held_item.velocity += body.velocity
	held_item.held = false
	held_item.z_index -= 1
	held_item = null

func destroy() -> void:
	held_item.queue_free()
	held_item = null
