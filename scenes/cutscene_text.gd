class_name CutsceneText extends Label

var text_to_set : PackedStringArray

func _ready() -> void:
	text_to_set = text.split("")
	text = ""

func update_text() -> bool:
	if text_to_set.is_empty():
		return false
	text += text_to_set.get(0)
	text_to_set.remove_at(0)
	return true
