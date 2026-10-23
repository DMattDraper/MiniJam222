class_name Cauldron extends Interactable

var item_count := 0

func interact(item: Item) -> bool:
	if item != null:
		print("Put %s into the cauldron!" % [item.name])
		item_count += 1
		return true
	
	print("No item to place in cauldron...")
	return false
