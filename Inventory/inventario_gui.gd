extends Control

var inventory_opened = false

@onready var inventory: Inventory = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $GridContainer.get_children()

func _ready():
	inventory.updated.connect(update)
	update()

func _process(_delta):
	var inventory_pressed = Input.is_action_just_pressed("inventario") # ("inventario")
	
	if inventory_opened:
		$".".show()
	else:
		$".".hide()
	if inventory_pressed:
		inventory_opened = !inventory_opened	


func _on_texture_button_pressed():
	inventory_opened = false
	$".".hide()
	
func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
		
