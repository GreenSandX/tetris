class_name BrickFactory

var brick_prefab = preload("res://Game/BrickFactory/Brick.tscn")

var typeList = {
	1:[
			[-2, 0],[-1, 0],[ 0, 0],[ 1, 0]	],	# I

	2:[						[ 0,-1],
			[-2, 0],[-1, 0],[ 0, 0],		],	# L
			
	3:[		[-2,-1],[-1,-1],[ 0,-1],
							[ 0, 0]			],	# L_flip

	4:[				[-1,-1],
			[-2, 0],[-1, 0],[ 0, 0]			],	# T

	5:[		[-1,-1],[ 0,-1],
					[ 0, 0],[ 1, 0]			],	# N

	6:[				[ 0,-1],[ 1,-1],
			[-1, 0],[ 0, 0]					],	# N_flip

	7:[		[-1,-1],[ 0,-1],
			[-1, 0],[ 0, 0]					]	# O
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


func create_brick_in(owner:Node2D, position:Vector2, type:int = 0) -> Node2D:
	#
	var brick:Node2D = brick_prefab.instance()
	brick.global_position = position
	owner.add_child(brick)
	#
	brick.get_material().set_shader_param("color", colorList.get(type))
	for i in typeList.get(type):
		brick.set_cell(i[0], i[1], 0)
	
	return brick



