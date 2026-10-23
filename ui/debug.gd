class_name Debug extends CanvasLayer

@onready var cat_state: Label = $CatState

func _ready() -> void:
	Statics.debug = self

func set_cat_state_label(state: String) -> void:
	cat_state.text = "Cat is %s" % [state]
