class_name Cauldron extends Interactable

var item_count := 0

func interact(item: Item) -> bool:
	if item == null:
		print("No item to place in cauldron...")
		return false
	
	if !is_valid_type(item):
		print("This item can't go in the cualdron...")
		return false
	
	if item.added_to_cauldron:
		print("You don't need another one of these...")
		return false
	
	print("Put %s into the cauldron!" % [item.name])
	item.added_to_cauldron = true
	item_count += 1
	
	if item_count == 5:
		print("You win!")
	
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
	if item is DewDrop:
		return true
	
	return false
