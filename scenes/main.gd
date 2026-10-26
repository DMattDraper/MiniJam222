class_name Main extends Node

@onready var main_menu: MainMenu = $MainMenu
@onready var intro_cutscene: Node = $IntroCutscene
@onready var world: Node = $World
@onready var victory_screen: Node = $VictoryScreen

func _ready() -> void:
	GameManager.main = self
	
	GameManager.main_menu = main_menu
	GameManager.intro_cutscene = intro_cutscene
	remove_child(intro_cutscene)
	GameManager.world = world
	remove_child(world)
	GameManager.victory_screen = victory_screen
	remove_child(victory_screen)
