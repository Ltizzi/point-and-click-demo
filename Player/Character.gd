extends CharacterBody2D

var direction:Vector2
var speed = 300

@export var inventory: Inventory

var old_position: Vector2
var moving: bool

var click_count: int

signal popup_menu
signal popup_menu_close

@export var anim_idle_speed: float

var action_type: String

func _ready():
	animIdle()
	moving = false

	
func _process(_delta):
	old_position = global_position
	
	#Actualiza posicion de texto
	#	$".."/CanvasLayer/Label.position = Vector2($Marker2D.global_position.x - 100, $Marker2D.global_position.y )	
	$".."/CanvasLayer/Label.global_position = $Marker2D.global_position

	var mouse_clicked = Input.is_action_just_released("left-click")
	var right_click = Input.is_action_just_pressed("right-click")
	
	#CLICKER DEBUG INFO
#	if mouse_clicked or right_click:
#		click_count += 1
#		print("=====================================")
#		print("Click counter: ", click_count)
#		print("=====================================")
#		print(" ")
#		print("pop up open: ", Globals.action_menu_open)
#		print("clicked with action open: ", Globals.clicked_with_action_menu_open)
#		print("mouse over gui: ", Globals.mouse_over_gui)
#		print(" ")
#		print("=====================================")

	
	if right_click and Globals.interactive_obj:
		print("")
		print("OPEN MENU")
		print("")
		Globals.action_menu_open = true
		popup_menu.emit()
	
	if mouse_clicked and Globals.action_menu_open and Globals.mouse_over_gui:
		print("from character")
		Globals.clicked_with_action_menu_open = true
	
	#POINT AND CLICK MOVEMENT	
	if mouse_clicked and not Globals.mouse_over_gui and not Globals.clicked_with_action_menu_open:
		if Globals.action_menu_open:
			Globals.action_menu_open = false
			Globals.interactive_obj = null
			popup_menu_close.emit()
			
		$AnimatedSprite2D.stop()
		direction = get_global_mouse_position()
		velocity = global_position.direction_to(direction) * speed
		var axis_x_delta = abs(direction.x - global_position.x) > 200
		if direction.y < global_position.y and not axis_x_delta:
			$AnimatedSprite2D.play("back_walk")
		if direction.y > global_position.y and not axis_x_delta:
			$AnimatedSprite2D.play("front_walk")
		if axis_x_delta:
			$AnimatedSprite2D.play("side_walk")
		moving = true
		
	$AnimatedSprite2D.flip_h = (global_position.x - direction.x) > 0
	
	if moving:
		move_and_slide()
	
	if global_position == old_position and moving:
		$AnimatedSprite2D.stop()
		moving = false
		animIdle()
	
	if abs(global_position - direction) < Vector2(5.0, 5.0) and moving:
		$AnimatedSprite2D.stop()
		moving = false		
		animIdle()
		
	
	
func actionHandler():
	Globals.mouse_over_gui = false
	
	print("ACTION HANDLER")
	var obj = Globals.interactive_obj
	print("OBJECT: ", obj)
	var text = ""
	if obj:
		if action_type == "look":
			if obj.has_method("look"):
				text = obj.look()
			else:
				text = "Nada para ver."
		if action_type == "talk":
			if obj.has_method("talk"):
				text = obj.talk()
			else:
				text = "No puedo hablar con eso."
		if action_type == "pick":
			if obj.has_method("pick"):
				text = obj.pick(inventory)
			else:
				text = "No puedo cojer eso."
		if action_type == "use":
			if obj.has_method("use"):
				text = obj.use()
			else:
				text = "No puedo usar eso."
		$"../CanvasLayer/Label".text = text	
		#$Label.text = text
		Globals.interactive_obj = null
		await get_tree().create_timer(2.5).timeout
		#$Label.text = ""

		$"../CanvasLayer/Label".text = ""

	
func animIdle():
	$AnimatedSprite2D.speed_scale = anim_idle_speed
	$AnimatedSprite2D.play("idle")



func _on_world_clicked_and_close_action_menu(type):
	action_type = type
	actionHandler()
