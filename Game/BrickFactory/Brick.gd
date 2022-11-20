
extends RigidBody2D
onready var collision_tile = $CollisionTileMap
onready var visiual_tile = $VisiualTileMap


var velocity:Vector2
var has_fade = false

var target_position:Vector2

func _ready():
	mass = 3
	custom_integrator = true
	target_position = position
	pass


func _process(delta):
	.set_gravity_scale(get_parent().getGravity())
	print(custom_integrator)
	pass


func _physics_process(delta):
	collision_tile.collision_use_parent = true
	collision_tile.collision_use_kinematic = true
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


func set_cell(x:int, y:int, type:int):
	collision_tile.set_cell(x, y, type)
	visiual_tile.set_cell(x, y, type)


func move(towards:Vector2):
#	collision_tile.position += towards * 16
#	visiual_tile.position += towards * 16
	target_position = position + towards * 16
	var target = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 0.08).set_trans(Tween.TRANS_CIRC)
	pass
