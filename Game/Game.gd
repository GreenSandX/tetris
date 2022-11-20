extends Node2D

onready var backgrd = $Background
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
	print(selected_brick)
#	if selected_brick != null:
#		selected_brick.custom_integrator = false
		
	pass


func _input(event):
	
	if event.is_action_pressed("ui_right"):
		selected_brick.move(Vector2.RIGHT)
#		selected_brick.position.x =  selected_brick.position.x + 16
	if event.is_action_pressed("ui_left"):
		selected_brick.move(Vector2.LEFT)
#		selected_brick.position.x =  selected_brick.position.x - 16
	if event.is_action_pressed("ui_up"):
		selected_brick.move(Vector2.UP)
#		selected_brick.position.y =  selected_brick.position.y - 16
	if event.is_action_pressed("ui_down"):
		selected_brick.move(Vector2.DOWN)
#		selected_brick.position.y =  selected_brick.position.y + 16
	
	if event.is_action_pressed("ui_end"):
		randomize()
		select_brick(
				brickFactory.create_brick_in(self, Vector2(
						(position.x + randi() % (WIDTH - 2) + 2) * BLOCK_STEP, 
						position.y + 16),
						randi() % 7 + 1))
		


#	if Input.is_mouse_button_pressed(BUTTON_LEFT):
#
	

func startGame():
	backgrd.Init(WIDTH, HEIGHT)
	centered(camera, WIDTH * BLOCK_STEP, HEIGHT * BLOCK_STEP)


func centered(node:Node2D, x:int, y:int ,x0:int = 0, y0:int = 0):
	node.position = Vector2((x + x0)/2, (y + y0)/2)
	


func select_brick(brick:Node2D):
	selected_brick = brick


func getGravity():
	return GRAVITY
