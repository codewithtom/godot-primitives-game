extends Node2D

func _ready():
	var player = get_node("/root/World/Player")
	player.position = position
	player.play_spawn_animation()