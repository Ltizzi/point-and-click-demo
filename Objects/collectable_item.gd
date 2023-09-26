extends Node2D

class_name CollectableItem

@export var itemRes: InventoryItem

@onready var isInteractive = true

var alreadyPicked: bool 
var getActionStrings = {}

func pick(inventory: Inventory):
	inventory.add(itemRes)


func look():
	pass

func clear():
	queue_free()
