extends TileMap

func _ready():
	visible = false

func Init(width, height):
	visible = true
	for i in range(width):
		for j in range(height):
			set_cell(i, j, 0)
	for i in range(width):
		set_cell(i, height, 1)
