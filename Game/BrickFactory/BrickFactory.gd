class_name BrickFactory
extends Node

var brick_prefab = preload("res://Game/BrickFactory/Brick.tscn")

enum Model{
	I, L, Lf, T, N, Nf, O
}


func create(position:Vector2, model = Model.I):
	var brick:Node2D = brick_prefab.instance()
	brick.global_position = position
	get_parent().add_child(brick)
	match model:
		Model.I:
			brick.set_cell(0, -1, 0)
	print(brick.position)
	

