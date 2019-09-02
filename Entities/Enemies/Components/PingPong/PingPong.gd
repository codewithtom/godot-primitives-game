extends Node

export var offset = Vector2()
export var speed = 2

onready var original_position = get_parent().position
var direction = 1

func _process(delta):
	var target = original_position + (offset*direction)
	var parent_position = get_parent().position
	get_parent().set_position(parent_position.linear_interpolate(target, speed * delta))
	
	var distance_to_target = parent_position.distance_to(target)
	if distance_to_target <= 1:
		direction = 1 if direction == -1 else -1
