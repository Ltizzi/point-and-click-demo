extends Node2D

signal clicked_and_close_action_menu(type)


func _ready():
	Globals.first_load = false
	


func _on_player_popup_menu():
	if Globals.action_menu_open and Globals.interactive_obj:
		var menu_position = get_global_mouse_position()
		var action_menu = $CanvasLayer/ActionMenu
		action_menu.visible = true
		action_menu.position = menu_position


func _on_player_popup_menu_close():
	close_action_menu()

#func _on_character_popup_menu():
#	if Globals.action_menu_open and Globals.interactive_obj:
#		var menu_position = get_global_mouse_position()
#		var action_menu = $CanvasLayer/ActionMenu
#		action_menu.visible = true
#		action_menu.position = menu_position
#
#func _on_character_popup_menu_close():
#	close_action_menu()

func _on_action_menu_clicked_action(type):
	close_action_menu()
	clicked_and_close_action_menu.emit(type)
	
func close_action_menu():
	
	await get_tree().create_timer(0.2).timeout
	$CanvasLayer/ActionMenu.hide()
	Globals.action_menu_open = false
	Globals.clicked_with_action_menu_open = false

func handleMouseOver():
	
	if Globals.mouse_over_gui:
		print(" ")
		print("mouse over action menu")
		print(" ")
	if not Globals.mouse_over_gui:
		print(" ")
		print("mouse exited action menu")
		print(" ")
	Globals.mouse_over_gui = !Globals.mouse_over_gui

func _on_action_menu_mouse_entered():
	Globals.mouse_over_gui = true
	#handleMouseOver()

func _on_action_menu_mouse_exited():
	Globals.mouse_over_gui = false
	#handleMouseOver()





