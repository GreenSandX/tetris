extends KinematicBody2D

onready var tile = $TileMap


var velocity:Vector2
var weight = 30

func _ready():
	set_safe_margin(0)
	pass


func _physics_process(delta):
	tile.collision_use_parent = true
	tile.collision_use_kinematic = true
	velocity = Vector2(0, get_parent().getGravity())
#	position += velocity
	move_and_slide(velocity * weight)
	

func set_cell(x:int, y:int, type:int):
	tile.set_cell(x, y, type)
