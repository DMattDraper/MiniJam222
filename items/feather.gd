class_name Feather extends Item

static var added_to_cauldron := false
static var first_pickup := true

func _ready() -> void:
	gravity *= 0.1

func grab() -> void:
	if first_pickup:
		first_pickup = false
		Statics.hud.update_message_text("The feather slows your falls!")
