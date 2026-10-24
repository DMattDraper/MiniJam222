extends Node

func reset() -> void:
	DewDrop.added_to_cauldron = false
	EyeOfNewt.added_to_cauldron = false
	Feather.added_to_cauldron = false
	Orchid.added_to_cauldron = false
	Toadstool.added_to_cauldron = false
	get_tree().reload_current_scene()
