extends Node2D

onready var backgrd = $Background
onready var camera = $Camera2D
onready var brickFactory = $BrickFactory

var BLOCK_STEP 	= 16
var WIDTH 		= 10
var HEIGHT 		= 16

var GRAVITY = 10 setget ,getGravity


func _ready():
	startGame()
	
	pass


func _process(delta):
	pass


func _input(event):
	
	if event.is_action_pressed("ui_right"):
		camera.position.x =  camera.position.x + 10
	if event.is_action_pressed("ui_left"):
		camera.position.x =  camera.position.x - 10
	if event.is_action_pressed("ui_up"):
		camera.position.y =  camera.position.y - 10
	if event.is_action_pressed("ui_down"):
		camera.position.y =  camera.position.y + 10
	
	if event.is_action_pressed("ui_end"):
		randomize()
		brickFactory.create(Vector2(position.x + randi() % (WIDTH + 1) * BLOCK_STEP, position.y + 16))
		print(randi() % (WIDTH + 1))
		
func startGame():
	backgrd.Init(WIDTH, HEIGHT)
	centered(camera, WIDTH * BLOCK_STEP, HEIGHT * BLOCK_STEP)
	
func centered(node:Node2D, x:int, y:int ,x0:int = 0, y0:int = 0):
	node.position = Vector2((x + x0)/2, (y + y0)/2)

func getGravity():
	return GRAVITY
