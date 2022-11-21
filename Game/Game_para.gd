class_name Game_para
extends Node

var BLOCK_STEP 	= 16
var WIDTH 		= 10
var HEIGHT 		= 16

var is_merging = false

var merge_timer = Timer.new()

	
#func merge_to(brick_A, tile_pos_A:Vector2, point_towards_A:Vector2, 
#				brick_B, tile_pos_B:Vector2, point_towards_B:Vector2):
#	merge_timer.connect("timeout", self, "merge_to")

func merge_to(  brick_A, tile_pos_A:Vector2, point_towards_A:Vector2, 
				brick_B, tile_pos_B:Vector2, point_towards_B:Vector2):
	if is_merging:
		return
	if brick_A.get_linear_velocity().length() > 1:
		return
	is_merging = true
	var new_tiles_pos_list = []
	var new_tiles_color:Color
	if brick_A.get_rid().get_id() > brick_B.get_rid().get_id():
		
		print(brick_A, tile_pos_A, point_towards_A, brick_B, tile_pos_B, point_towards_B)
		
		new_tiles_pos_list = brick_B.tiles_pos_list
		new_tiles_color = brick_B.color
		brick_B.queue_free()
		# 
		
		print("merge at A :", tile_pos_A, " , and B :", tile_pos_B)
		
		print("tiles_pos_list:  ", new_tiles_pos_list)
		
		
		var rotate_deg = point_towards_B.angle_to(point_towards_A * -1)
#		print(rotate_deg)
#		if abs(rotate_deg - PI/2) <= 0.5:
#			rotate_deg = PI/2
#		elif abs(rotate_deg - PI) <= 0.5:
#			rotate_deg = PI
#		elif abs(rotate_deg - (-PI/2)) <= 0.5:
#			rotate_deg = -PI/2
#		else :
#			return
		
		var j = []
		for i in range(new_tiles_pos_list.size()):
			
			# 移动 B 的 Tile 的原点位置 到接触的 B Tile 坐标（平移）
			j.append(new_tiles_pos_list[i] - tile_pos_B)
			
			# 旋转 B 的 Tile
			j[i] = j[i].rotated(rotate_deg)
			
			# 移动 B 的 Tile 的原点位置 到接触的 A Tile 朝向 point_towards 的坐标
			j[i] += (tile_pos_A + point_towards_A)
			
		new_tiles_pos_list = j
		print("transted: 		", new_tiles_pos_list)
		
		for i in new_tiles_pos_list:
			var x = i.x
			var y = i.y
			print(x, ", ", y)
			brick_A.add_cell(x, y)

	is_merging = false
