extends Node

var current_level = null
var current_level_name = null

func change_level(level_name):
	call_deferred("_deferred_change_level", level_name)

func reset_level():
	call_deferred("_deferred_change_level", current_level_name)

func _deferred_change_level(level_name):
	if !current_level:
		current_level = get_node("/root/World/Level")
	
	if current_level:
		current_level.free()
		for bullet in get_tree().get_nodes_in_group("bullet"):
			bullet.queue_free()
	
	var scene = ResourceLoader.load("res://Levels/%s.tscn" % level_name)
	current_level = scene.instance()
	current_level_name = level_name
	
	get_node("/root/World").add_child(current_level)