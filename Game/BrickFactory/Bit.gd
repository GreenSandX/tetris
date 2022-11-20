class_name Bit
extends Area2D

onready var link_point_prefab = preload("./LinkPoint.tscn")
onready var bit_shape_prefab  = preload("./Bit_Shape.tscn")

var BLOCK_STEP_HLAF = GamePara.BLOCK_STEP / 2

var in_brick_position:Vector2
var shape_owner:int


func _init(x:int, y:int):
	in_brick_position = Vector2(x, y)
	position = Vector2(
			x * BLOCK_STEP_HLAF * 2 + BLOCK_STEP_HLAF,
			y * BLOCK_STEP_HLAF * 2 + BLOCK_STEP_HLAF)


func _ready():
	shape_owner = create_shape_owner(self)
	set_collision_layer(2)
	set_collision_mask(2)
	add_link_point( 1,  0)
	add_link_point(-1,  0)
	add_link_point( 0, -1)
	add_link_point( 0,  1)


func add_link_point(x:int, y:int) -> Area2D:
	var link_point = link_point_prefab.instance()
	link_point.position = Vector2(x, y) * BLOCK_STEP_HLAF
	add_child(link_point)
	return link_point


func get_shape() -> Shape2D:
	var rec = RectangleShape2D.new()
	rec.set_extents(Vector2(BLOCK_STEP_HLAF - 0.1, BLOCK_STEP_HLAF - 0.1))
	return rec


func add_shape_to(owner:int):
	var rec = RectangleShape2D.new()
	rec.set_extents(Vector2(BLOCK_STEP_HLAF - 0.1, BLOCK_STEP_HLAF - 0.1))
	shape_owner_add_shape(owner, rec)
	shape_owner_set_transform(owner, Transform2D(0.0, Vector2.ZERO))


func _process(delta):
	pass
