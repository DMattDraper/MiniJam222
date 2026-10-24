extends Behavior

@export var max_detection := 2.0
var detection = 0.0

func handle_behavior(delta: float) -> void:
	var movement = Statics.player.velocity.length()
	if movement >= 0.5:
		detection += delta
	else:
		detection -= delta * 0.5
		if detection < 0.0:
			detection = 0.0
	
	if detection >= max_detection:
		GameManager.reset()
