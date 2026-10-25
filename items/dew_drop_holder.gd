class_name DewDropHolder extends Item

static var added_to_cauldron := false

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var filled := false

func fill() -> void:
	filled = true
	sprite.frame = 4

func _on_fill_box_body_entered(body):
	if body is DewDrop:
		if !filled:
			print("Filled!")
			fill()
		if body.has_method("delete_self"):
			body.delete_self()
