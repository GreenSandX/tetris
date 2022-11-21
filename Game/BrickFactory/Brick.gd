class_name Brick
extends RigidBody2D

onready var visiual_tile = $VisiualTileMap


var velocity:Vector2
var has_fade = false
var color:Color
var tiles_pos_list = []
var is_merging = false

var shape_owner

var link_points_list = []

func _ready():
	mass = 3
	custom_integrator = true
	shape_owner = create_shape_owner(self)

	pass


func _process(delta):
	.set_gravity_scale(get_parent().getGravity())
	pass


func _physics_process(delta):
	
	velocity = Vector2(0, get_parent().getGravity())
#	position += velocity
#	move_and_slide(velocity * weight)
	if linear_velocity.length() <= 0.5 && linear_velocity.length() >= 0.005 && has_fade == true:
		if (Vector2(int(position.x) % 16, int(position.y) % 16)).length() <= 0.02:
#			set_linear_damp(100) 
			
			pass
	has_fade = true


func _integrate_forces(state):
#	state.apply_central_impulse(target_position - position)
	state.apply_central_impulse(Vector2(0, mass))
	pass


func add_cell(x, y):
	print("adding cell at : ", x, ", ", y)
	# 增加贴图
	visiual_tile.set_cellv(Vector2(x, y), 0)

	
#	visiual_tile.fix_invalid_tiles()
	print("now tiles is : ", visiual_tile.get_used_cells())
	tiles_pos_list.append(Vector2(x, y))
	# 增加碰撞逻辑块 Bit
	add_bit(Vector2(x, y))


func add_bit(tile_pos:Vector2):
	# 按坐标增加 Bit 块
	var bit = Bit.new(tile_pos.x, tile_pos.y)
	add_child(bit)
	# 增加新的 Shape
#	bit.add_shape_to(shape_owner)
	var owner = create_shape_owner(self)
	shape_owner_add_shape(owner,bit.get_shape())
	shape_owner_set_transform(owner, Transform2D(0.0, Vector2(
			tile_pos.x * 16 + 8, tile_pos.y * 16 + 8) ))
	bit.connect("connected", self, "merge_to")


func set_tile_map_color(tile_map:TileMap, color:Color):
	if	tile_map == null:
		get_material().set_shader_param("color", color)
	else:
		tile_map.get_material().set_shader_param("color", color)


func move_towards(towards:Vector2):
	var target_position = position + towards * 16
	move_to(target_position)


func move_to(target_position:Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 0.08).set_trans(Tween.TRANS_CIRC)


func set_rigi_mode(mode:int):
	set_mode(mode)


func merge_to(  brick_A:Brick, tile_pos_A:Vector2, point_towards_A:Vector2, 
				brick_B:Brick, tile_pos_B:Vector2, point_towards_B:Vector2):
#	GamePara.merge_to(
#				brick_A, tile_pos_A, point_towards_A, 
#				brick_B, tile_pos_B, point_towards_B)
	if brick_A.is_merging:
		return
	brick_A.is_merging = true
	if brick_A.tiles_pos_list.size() < brick_B.tiles_pos_list.size():
		return
	if true:#brick_A.get_rid().get_id() > brick_B.get_rid().get_id():

		print(brick_A, tile_pos_A, point_towards_A, brick_B, tile_pos_B, point_towards_B)

		var new_tiles_pos_list = brick_B.tiles_pos_list
		var new_tiles_color = brick_B.color
		brick_B.queue_free()
		# 

		print("merge at A :", tile_pos_A, " , and B :", tile_pos_B)

		print("tiles_pos_list:  ", new_tiles_pos_list)


		var rotate_deg = point_towards_B.angle_to(point_towards_A * -1)
		var j = []
		for i in range(new_tiles_pos_list.size()):

			# 移动 B 的 Tile 的原点位置 到接触的 B Tile 坐标（平移）
			j.append(new_tiles_pos_list[i] - tile_pos_B)

			# 旋转 B 的 Tile
#			j[i] = j[i].rotated(rotate_deg)

			# 移动 B 的 Tile 的原点位置 到接触的 A Tile 朝向 point_towards 的坐标
			j[i] += (tile_pos_A + point_towards_A)

		new_tiles_pos_list = j
		print("transted: 		", new_tiles_pos_list)

		for i in new_tiles_pos_list:
			var x = i.x
			var y = i.y
			print(x, ", ", y)
			brick_A.add_cell(x, y)
			
	brick_A.is_merging = false
	
