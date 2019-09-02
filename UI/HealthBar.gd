extends TextureProgress

var player

func _ready():
	player = get_node("/root/World/Player")
	player.connect("health_updated", self, "_on_player_health_updated")

func _on_player_health_updated(current_health, max_health):
	max_value = max_health
	value = current_health