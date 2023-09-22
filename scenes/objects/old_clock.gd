extends Node2D

var isInteractive = true

var getActionStrings = {
	"look": [
		"Son las 9:00 hace 15 años",
		"Es un viejo reloj con péndulo que no funciona."
	],
	
}

func look():
	var index = getActionStrings.size()
	return getActionStrings["look"][randi_range(0, index)]


func _on_texture_button_mouse_entered():
	print("wadasdasd")
	print(self)
	Globals.is_mouse_over_interactive_obj = true
	Globals.interactive_obj = self
	


func _on_texture_button_mouse_exited():
	Globals.is_mouse_over_interactive_obj = false
#	if not Globals.mouse_over_gui:
#		Globals.interactive_obj = null


func _on_texture_button_pressed():
	Globals.interactive_obj = self
