class_name Brick
extends RigidBody2D

onready var visiual_tile = $VisiualTileMap


var velocity:Vector2
var has_fade = false

var shape_owner


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
#			set_mode(1)
			set_sleeping(true) 
			pass
	has_fade = true


func _integrate_forces(state):

#	state.apply_central_impulse(target_position - position)
	state.apply_central_impulse(Vector2(0, mass))
	pass


func add_cell(x:int, y:int):
	# 增加贴图
	visiual_tile.set_cell(x, y, 0)
	# 按坐标增加 Bit 块
	var bit = Bit.new(x, y)
	add_child(bit)
	# 增加新的 Shape 至 shape_owner
#	bit.add_shape_to(shape_owner)
	var owner = create_shape_owner(self)
	shape_owner_add_shape(owner,bit.get_shape())
	shape_owner_set_transform(owner, Transform2D(0.0, Vector2(
			x * 16 + 8, y * 16 + 8) ))


func move_towards(towards:Vector2):
	var target_position = position + towards * 16
	move_to(target_position)


func move_to(target_position:Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 0.08).set_trans(Tween.TRANS_CIRC)


func set_rigi_mode(mode:int):
	set_mode(mode)


func merge_to(brick:Brick):
	pass
