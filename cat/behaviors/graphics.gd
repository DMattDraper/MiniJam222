class_name Graphics extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play(animation: String) -> void:
	animation_player.play(animation)

func stop() -> void:
	animation_player.stop()
