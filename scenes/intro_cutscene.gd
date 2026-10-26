extends Node

@onready var v_box: VBoxContainer = $CanvasLayer/VBoxContainer
@onready var labels : Array
@onready var active_label : CutsceneText

@onready var timer
var text_speed = 0.05
var word_space = 10
var pause_remaining = 0

func _ready() -> void:
	labels = v_box.get_children()
	
	timer = Timer.new()
	timer.wait_time = text_speed
	timer.timeout.connect(update_text)
	add_child(timer)
	timer.start()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		GameManager.skip_cutscene()

func update_text() -> void:
	if pause_remaining > 0:
		pause_remaining -= 1
		return
	
	if active_label == null and labels.size() == 0:
		return
	
	if active_label == null:
		active_label = labels.get(0)
		labels.remove_at(0)
	
	if !active_label.update_text():
		active_label = null
		pause_remaining = word_space
