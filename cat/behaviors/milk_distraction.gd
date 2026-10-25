extends Behavior

var filled := false
@onready var saucer: CharacterBody2D = $Saucer

func _ready() -> void:
	super()
	
	remove_child(saucer)
	room.add_child.call_deferred(saucer)
	saucer.position = Vector2(0.0, Statics.game_screen_height / 2.0 - 16.0)
	
	saucer.filled_saucer.connect(fill_saucer)

func activate() -> void:
	super()
	graphics.play("appear")
	if filled:
		Statics.cat.change_state(Cat.STATES.DISTRACTED)
		Statics.hud.update_message_text("The cat is drinking the milk!")
		filled = false
		await get_tree().create_timer(Statics.cat.distract_time - 1.0).timeout
		saucer.empty_saucer()
		Statics.hud.update_message_text("The cat finished the milk!")
	else:
		pass

func deactivate() -> void:
	super()
	graphics.play("disappear")

func fill_saucer():
	filled = true
