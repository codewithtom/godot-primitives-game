extends Node2D

var bullet = preload("res://Bullet/Bullet.tscn")

export var initial_delay = 0.0
export var fire_rate = 1.0
export var fire_at_player = false

var initialized = false
var can_fire = true
var player

func _ready():
	player = get_node("/root/World/Player")
	yield(get_tree().create_timer(initial_delay), "timeout")
	initialized = true

func _process(delta):
	if initialized and can_fire:
		fire()

func fire():

	var bullet_instance = bullet.instance()
	bullet_instance.friendly = false
	bullet_instance.position = get_parent().get_global_position()
	var target_position = player.get_global_position() if fire_at_player else get_global_position()
	bullet_instance.direction = get_parent().get_global_position().direction_to(target_position)
	get_tree().get_root().add_child(bullet_instance)
	
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true