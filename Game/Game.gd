extends Node2D

onready var background = $Background
onready var camera = $Camera2D

var brickFactory = preload("res://Game/BrickFactory/BrickFactory.gd").new()
var selected_brick:Node2D

var BLOCK_STEP 	= 16
var WIDTH 		= 10
var HEIGHT 		= 16

var GRAVITY = 5 setget ,getGravity


func _ready():
	startGame()
	pass


func _process(delta):
#	if selected_brick != null:
#		selected_brick.custom_integrator = false

	
		
	pass


func _input(event):
	
	if event.is_action_pressed("ui_right"):
		if selected_brick == null:
			return
		selected_brick.move_towards(Vector2.RIGHT)
#		selected_brick.position.x =  selected_brick.position.x + 16
	if event.is_action_pressed("ui_left"):
		if selected_brick == null:
			return
		selected_brick.move_towards(Vector2.LEFT)
#		selected_brick.position.x =  selected_brick.position.x - 16
	if event.is_action_pressed("ui_up"):
		if selected_brick == null:
			return
		selected_brick.move_towards(Vector2.UP)
#		selected_brick.position.y =  selected_brick.position.y - 16
	if event.is_action_pressed("ui_down"):
		if selected_brick == null:
			return
		selected_brick.move_towards(Vector2.DOWN)
#		selected_brick.position.y =  selected_brick.position.y + 16
	
	if event.is_action_pressed("ui_end"):
		randomize()
		select_brick(
				brickFactory.create_brick_in(self, Vector2(
						(position.x + randi() % (WIDTH - 2) + 2) * BLOCK_STEP, 
						position.y + 16),
#						randi() % 7 + 1))
						0))
	
	if event.is_action_pressed("btn_1"):
		brickFactory.next_type = 1
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			brickFactory.create_brick_in(self, get_global_mouse_position(), 2)
#
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_RIGHT and event.pressed:
#			selected_brick.move_to(get_global_mouse_position())


func startGame():
	if background != null:
		background.create(WIDTH, HEIGHT)
		centered(camera, WIDTH * BLOCK_STEP, HEIGHT * BLOCK_STEP)


func centered(node:Node2D, x:int, y:int , _x:int = 0, _y:int = 0):
	node.position = Vector2((x + _x)/2, (y + _y)/2)


func select_brick(brick:Node2D):
	selected_brick = brick


func getGravity():
	return GRAVITY



