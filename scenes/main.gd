class_name Main extends Node

@onready var main_menu: MainMenu = $MainMenu
@onready var world: Node = $World

func _ready() -> void:
	GameManager.main = self
	
	GameManager.main_menu = main_menu
	GameManager.world = world
	remove_child(world)
