extends Node

func die() -> void:
	Statics.player.item_holder.drop()
	Statics.player.position = Statics.player.starting_position
	
	var items = get_tree().get_nodes_in_group("items")
	for item in items:
		if item is Item and item.reset_on_death:
			item.reset()
	
	Statics.hud.update_message_text("You were caught by the Cat! Don't give up!")

func reset() -> void:
	DewDropHolder.added_to_cauldron = false
	EyeOfNewt.added_to_cauldron = false
	Feather.added_to_cauldron = false
	Orchid.added_to_cauldron = false
	Toadstool.added_to_cauldron = false
	get_tree().reload_current_scene()
