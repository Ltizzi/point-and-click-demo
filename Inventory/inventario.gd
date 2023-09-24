extends Control

var inventory_opened = false

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
