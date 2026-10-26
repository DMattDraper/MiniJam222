extends Node

@onready var main : Main

@onready var main_menu : MainMenu
@onready var intro_cutscene : Node
@onready var world : Node
@onready var victory_screen : Node

func die() -> void:
	var behavior := Statics.world.current_room.cat_behavior
	if behavior:
		behavior.deactivate()
	
	Statics.player.item_holder.drop()
	Statics.player.position = Statics.player.starting_position
	
	var items = get_tree().get_nodes_in_group("items")
	for item in items:
		if item is Item and item.reset_on_death:
			item.reset()
	
	Statics.cat.change_state(Cat.STATES.WANDERING)
	
	Statics.hud.update_message_text("You were caught by the Cat! Don't give up!")

func reset() -> void:
	DewDropHolder.added_to_cauldron = false
	EyeOfNewt.added_to_cauldron = false
	Feather.added_to_cauldron = false
	Orchid.added_to_cauldron = false
	Toadstool.added_to_cauldron = false
	get_tree().reload_current_scene()

func start_game() -> void:
	main.remove_child(main_menu)
	main.add_child(intro_cutscene)

func skip_cutscene() -> void:
	main.remove_child(intro_cutscene)
	main.add_child(world)

func win_game() -> void:
	main.remove_child(world)
	main.add_child(victory_screen)

func quit() -> void:
	get_tree().quit()
