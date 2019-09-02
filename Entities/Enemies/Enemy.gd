extends Area2D

class_name Enemy

signal took_damage
signal died

export var max_health = 1

var current_health = max_health

func _process(delta):
	var player_exists = get_tree().get_root().has_node("World/Player")
	if !player_exists:
		return
	
	var player = get_node("/root/World/Player")
	if overlaps_body(player):
		player.take_damage(1)

func take_damage(damage):
	current_health = clamp(current_health - damage, 0, max_health)
	
	if current_health == 0:
		emit_signal("died")
		die()
	else:
		emit_signal("took_damage", damage)
		took_damage(damage)

func took_damage(damage):
	pass

func die():
	queue_free()