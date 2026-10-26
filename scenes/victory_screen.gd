extends Node

@onready var description: Label = $CanvasLayer/Description

func update_text() -> void:
	description.text = "You evaded the cat and returned to normal size in %0.2f seconds." % [GameManager.time]
