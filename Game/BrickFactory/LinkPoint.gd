extends Area2D

signal touched(point_A, pointB)

var in_tile_towards:Vector2

var timer = Timer.new()
var target_point

func _on_LinkPoint_area_entered(area):
	target_point = area
	add_child(timer)
	timer.set_wait_time(1) 
	timer.start()
	timer.connect("timeout", self, "timeout")


func _on_LinkPoint_area_exited(area):
	if area == target_point:
		timer.stop()


func timeout():
	emit_signal("touched", self, target_point)
	print("Time_out!")
		
func set_towards(towards:Vector2):
	in_tile_towards = towards


func get_towards() -> Vector2:
	return in_tile_towards

