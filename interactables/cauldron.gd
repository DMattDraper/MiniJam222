class_name Cauldron extends Interactable

var item_count := 0
@onready var feather: AnimatedSprite2D = $Icons/Feather
@onready var eye_of_newt: AnimatedSprite2D = $Icons/EyeOfNewt
@onready var toadstool: AnimatedSprite2D = $Icons/Toadstool
@onready var dew_drop: AnimatedSprite2D = $Icons/DewDrop
@onready var orchid: AnimatedSprite2D = $Icons/Orchid

func interact(item: Item) -> bool:
	if item == null:
		Statics.hud.update_message_text("No item to add to cauldron...")
		return false
	
	if !is_valid_type(item):
		Statics.hud.update_message_text("This item can't go in the cauldron...")
		return false
	
	if item is DewDropHolder and !item.filled:
		Statics.hud.update_message_text("You need a drop of dew for the cauldron...")
		return false
	
	if item.added_to_cauldron:
		Statics.hud.update_message_text("You don't need another one of these...")
		return false
	
	$AddSound.play()
	Statics.hud.update_message_text("Added %s to the cauldron!" % [item.item_name])
	item.added_to_cauldron = true
	item_count += 1
	update_icons(item)
	
	if item_count == 5:
		GameManager.win_game()
	
	return true

func is_valid_type(item: Item) -> bool:
	if item is Feather:
		return true
	if item is EyeOfNewt:
		return true
	if item is Orchid:
		return true
	if item is Toadstool:
		return true
	if item is DewDropHolder:
		return true
	
	return false

func update_icons(item: Item) -> void:
	if item is Feather:
		feather.modulate = Color.WHITE
	if item is EyeOfNewt:
		eye_of_newt.modulate = Color.WHITE
	if item is Orchid:
		orchid.modulate = Color.WHITE
	if item is Toadstool:
		toadstool.modulate = Color.WHITE
	if item is DewDropHolder:
		dew_drop.modulate = Color.WHITE
