extends Control

signal clicked_action(type)


#ACTIONS

func clickedAction(type):
	print("from action menu")
	Globals.clicked_with_action_menu_open = true
	clicked_action.emit(type)

func _on_look_at_pressed():
	print(" ")
	print("look at pressed")
	print(" ")
	clickedAction("look")

func _on_use_pressed():
	print(" ")
	print("use pressed")
	print(" ")
	clickedAction("use")

func _on_talk_pressed():
	print(" ")
	print("talk pressed")
	print(" ")
	clickedAction("talk")



func _on_pick_pressed():
	print(" ")
	print("pick pressed")
	print(" ")
	clickedAction("pick")
	
#MOUSE OVER PANEL

#func handleMouseOver():
#
#
#	if Globals.mouse_over_gui:
#		print(" ")
#		print("mouse over action menu")
#		print(" ")
#	if not Globals.mouse_over_gui:
#		print(" ")
#		print("mouse exited action menu")
#		print(" ")
#	Globals.mouse_over_gui = !Globals.mouse_over_gui
#
#
#func _on_panel_mouse_entered():
#	Globals.mouse_over_gui = true
#	handleMouseOver()
#
#
#
#func _on_panel_mouse_exited():
#	Globals.mouse_over_gui = false
#	handleMouseOver()
	
