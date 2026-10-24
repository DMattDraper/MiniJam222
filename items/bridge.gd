class_name Bridge extends Item

@onready var static_body: StaticBody2D = $StaticBody2D

func _ready() -> void:
	static_body.add_collision_exception_with(self)

func _process(_delta: float) -> void:
	if global_position.y < Statics.player.global_position.y:
		static_body.add_collision_exception_with(Statics.player)
	else:
		static_body.remove_collision_exception_with(Statics.player)

func grab():
	static_body.collision_layer = 0

func drop():
	static_body.collision_layer = 2
