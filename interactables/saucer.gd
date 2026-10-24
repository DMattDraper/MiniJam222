extends Interactable

var filled := false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal filled_saucer

func interact(_item: Item) -> bool:
	if filled:
		Statics.hud.update_message_text("The saucer is already filled...")
		return false
	
	filled = true
	sprite.play("filled")
	filled_saucer.emit()
	
	return true

func empty_saucer():
	filled = false
	sprite.play("empty")
