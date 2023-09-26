extends CharacterBody2D

var direction:Vector2
var speed = 300

@export var inventory: Inventory
@export var anim_idle_speed: float

var old_position: Vector2
var moving: bool
var moving_to_object: bool
var next_to_object: bool
var obj_position: Vector2

var click_count: int

signal popup_menu
signal popup_menu_close


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
#		var axis_x_delta = abs(direction.x - global_position.x) > 200
#		if direction.y < global_position.y and not axis_x_delta:
#			$AnimatedSprite2D.play("back_walk")
#		if direction.y > global_position.y and not axis_x_delta:
#			$AnimatedSprite2D.play("front_walk")
#		if axis_x_delta:
#			$AnimatedSprite2D.play("side_walk")
		handleMovementAnimations()
		moving = true
		
	$AnimatedSprite2D.flip_h = (global_position.x - direction.x) > 0
	
	if moving:
		move_and_slide()
		
	if moving_to_object and not next_to_object:
		direction = obj_position
		velocity = global_position.direction_to(direction) * speed
		handleMovementAnimations()
		move_and_slide()
		print("RESTA:")
		print(abs(position - direction))
		if abs(position - direction) < Vector2(50.0, 50.0) and moving_to_object:
			print("ENTRO")
			$AnimatedSprite2D.stop()
			moving_to_object = false
			next_to_object = true
			actionHandler()
	
	if global_position == old_position and moving:
		handleStopAnimation()
	
	if abs(global_position - direction) < Vector2(5.0, 5.0) and moving:
		handleStopAnimation()
		
	
	
func actionHandler():
	Globals.mouse_over_gui = false
	
	print("ACTION HANDLER")
	var obj = Globals.interactive_obj
	obj_position = obj.position
	print("OBJECT: ", obj.position, " ", position, " ", global_position)
	var text = ""
	
	if abs(global_position - obj.position  ) > Vector2(10.0,10.0) and not next_to_object:
		moving_to_object = true
		next_to_object = false
		print("obj pos: ", obj_position)
	#TODO: hacer los objetos reacheables
	#cambiado por checkRelativePositions de ambos ejes
	#abs(position - obj_position) < Vector2(10.0, 10.0) or
	#checkRelativePositions:
	#abs(obj_position.x - position.x) <= 30.0 or abs(obj_position.y - position.y) <= 30.0
	if  checkRelativePosition(obj_position.x) or checkRelativePosition(obj_position.y):
		next_to_object = true
	if not moving_to_object and next_to_object:
		next_to_object = false
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

func handleMovementAnimations():
	var axis_x_delta = abs(direction.x - global_position.x) > 200
	if direction.y < global_position.y and not axis_x_delta:
		$AnimatedSprite2D.play("back_walk")
	if direction.y > global_position.y and not axis_x_delta:
		$AnimatedSprite2D.play("front_walk")
	if axis_x_delta:
		$AnimatedSprite2D.play("side_walk")

func handleStopAnimation():
	$AnimatedSprite2D.stop()
	moving = false
	animIdle()
	
func checkRelativePosition(obj_pos_axis):
	return abs(obj_pos_axis - position.x) <= 30.0 or abs(obj_pos_axis - position.y) <= 30.0

func _on_world_clicked_and_close_action_menu(type):
	action_type = type
	actionHandler()
