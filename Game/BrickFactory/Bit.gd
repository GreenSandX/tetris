class_name Bit
extends Area2D

onready var link_point_prefab = preload("./LinkPoint.tscn")

signal connected(brick_A, tile_pos_A, point_towards_A,
		brick_B, tile_pos_B, point_towards_B)

var BLOCK_STEP_HLAF = GamePara.BLOCK_STEP / 2

var in_brick_position:Vector2

var link_points_list



func _init(x:int, y:int):
	in_brick_position = Vector2(x, y)
	position = Vector2(
			x * BLOCK_STEP_HLAF * 2 + BLOCK_STEP_HLAF,
			y * BLOCK_STEP_HLAF * 2 + BLOCK_STEP_HLAF)


func _ready():
	set_collision_layer(2)
	set_collision_mask(2)
	add_link_point( 1,  0)
	add_link_point(-1,  0)
	add_link_point( 0, -1)
	add_link_point( 0,  1)


func add_link_point(x:int, y:int) -> Area2D:
	var link_point = link_point_prefab.instance()
	link_point.position = Vector2(x, y) * BLOCK_STEP_HLAF
	link_point.set_towards(Vector2(x, y))
	add_child(link_point)
	link_point.connect("touched", self, "on_bit_touched")
	return link_point


func get_shape() -> Shape2D:
	var rec = RectangleShape2D.new()
	rec.set_extents(Vector2(BLOCK_STEP_HLAF - 0.1, BLOCK_STEP_HLAF - 0.1))
	return rec


func on_bit_touched(point_A:Area2D, point_B:Area2D):
	var brick_B = point_B.get_parent().get_parent()
	if brick_B == get_parent():
		point_B.queue_free()
	else:
		if get_parent().is_merging or brick_B.is_merging:
			return
		# 确认后转发具体的合并信息
		emit_signal("connected", 
				get_parent(), in_brick_position, point_A.get_towards(),
				brick_B, point_B.get_parent().in_brick_position, point_B.get_towards())
