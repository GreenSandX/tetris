class_name BrickFactory

var brick_prefab = preload("./Brick.tscn")

var next_type:int = 0

var next_list = [1,4]

var typeList = {
	1:[
			[-2, 0],[-1, 0],[ 0, 0],[ 1, 0]	],	# I

	2:[						[ 0,-1],
			[-2, 0],[-1, 0],[ 0, 0],		],	# L

	3:[		[-2,-1],[-1,-1],[ 0,-1],
							[ 0, 0]			],	# L_flip

	4:[				[-1,-1],
			[-2, 0],[-1, 0],[ 0, 0]			],	# T

	5:[				[-1,-1],[ 0,-1],
							[ 0, 0],[ 1, 0]	],	# N

	6:[						[ 0,-1],[ 1,-1],
					[-1, 0],[ 0, 0]			],	# N_flip

	7:[				[-1,-1],[ 0,-1],
					[-1, 0],[ 0, 0]			]	# O
}

var colorList = {
	1:Color("ffc0b914"),
	2:Color("ffc02014"),
	3:Color("ff1467c0"),
	4:Color("ff5ec014"),
	5:Color("ffb316d3"),
	6:Color("ffc06d14"),
	7:Color("ff14c090")
}


func create_brick_in(owner:Node2D, position:Vector2, type:int) -> Node2D:
	#
	var brick:Node2D = brick_prefab.instance()
	brick.global_position = position
	owner.add_child(brick)
	
	if type == 0:
		type = next_list.pop_back()
		randomize()
		next_list.push_front(randi() % 7 + 1)
	# 增加 块
	for i in typeList.get(type):
		brick.add_cell(i[0], i[1])
	# 改变 颜色
	brick.set_tile_map_color(null, colorList.get(type))
	
	return brick

func rand():
	randomize()
	next_type = randi() % 7 + 1


