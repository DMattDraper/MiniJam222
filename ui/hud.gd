class_name HUD extends CanvasLayer

@onready var message_text : Label = $MessageText
@onready var interaction_text: Label = $InteractionText
@onready var cat_text: Label = $CatText
var message_text_timer : Timer

func _ready() -> void:
	Statics.hud = self
	
	message_text_timer = Timer.new()
	message_text_timer.one_shot = true
	message_text_timer.wait_time = 3.0
	message_text_timer.timeout.connect(clear_message_text)
	add_child(message_text_timer)
	
	clear_message_text()
	update_interaction_text("")
	update_cat_text("")

func update_message_text(text: String) -> void:
	message_text.text = text
	message_text_timer.start()

func clear_message_text() -> void:
	message_text.text = ""

func update_interaction_text(text: String) -> void:
	interaction_text.text = text

func update_cat_text(text: String) -> void:
	cat_text.text = text
