class_name Cauldron extends Interactable

var item_count := 0

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
	
	Statics.hud.update_message_text("Added %s to the cauldron!" % [item.item_name])
	item.added_to_cauldron = true
	item_count += 1
	
	if item_count == 5:
		Statics.hud.update_message_text("You win!")
	
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
