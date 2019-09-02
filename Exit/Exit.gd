extends Area2D

export var next_level_name : String = "Level"

var player
var is_active = false

func _ready():
	player = get_node("/root/World/Player")
	player.connect("exited", self, "_player_exited")
	hide()

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("enemy")
	if !enemies or enemies.size() == 0:
		show()
		is_active = true
	
func _on_body_entered(body):
	if is_active and body.is_in_group("player"):
		player.position = position
		player.play_exit_animation()

func _player_exited():
	LevelManager.change_level(next_level_name)
