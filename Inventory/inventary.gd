extends Resource

class_name Inventory

signal updated

@export var id: int
@export var owner_type: String
@export var items: Array[InventoryItem]

func add(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
	updated.emit()
