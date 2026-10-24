extends Interactable

@onready var mouse: Mouse

func _ready() -> void:
	mouse = get_parent()

func interact(_item: Item) -> bool:
	mouse.scare()
	return true
