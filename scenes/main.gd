class_name Main extends Node

@onready var main_menu: MainMenu = $MainMenu
@onready var world: Node = $World
@onready var victory_screen: Node = $VictoryScreen

func _ready() -> void:
	GameManager.main = self
	
	GameManager.main_menu = main_menu
	GameManager.world = world
	remove_child(world)
	GameManager.victory_screen = victory_screen
	remove_child(victory_screen)
