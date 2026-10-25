extends Behavior

@export var max_detection := 2.0
var detection = 0.0

@onready var eyes: Sprite2D = $Eyes

func _ready() -> void:
	super()
	
	remove_child(eyes)
	graphics.add_child.call_deferred(eyes)

func handle_behavior(delta: float) -> void:
	var movement = Statics.player.velocity.length()
	if movement >= 0.5:
		detection += delta
	else:
		detection -= delta * 0.5
		if detection < 0.0:
			detection = 0.0
	
	Statics.hud.update_cat_text("DETECTION: %s/100" % [int((detection / max_detection) * 100.0)])
	eyes.modulate.a = detection / max_detection
	
	if detection >= max_detection:
		Statics.player.kill()

func activate() -> void:
	super()
	eyes.show()

func deactivate() -> void:
	super()
	eyes.hide()
