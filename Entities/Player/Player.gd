extends KinematicBody2D

signal exited
signal health_updated
signal took_damage
signal died

var bullet = preload("res://Bullet/Bullet.tscn")

export var max_health = 1
export var speed = 200
export var fire_rate = 0.5

onready var current_health = max_health
var can_fire = true
var input_locked = true setget set_input_locked

func _process(delta):
	if !input_locked:
		handle_movement()
		handle_weapon_fire()

func handle_movement():
	var velocity = Vector2()
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	move_and_slide(velocity * speed)
	$AnimationPlayer.play("idle")

func handle_weapon_fire():
	if Input.is_action_pressed("shoot") and can_fire:
		var new_bullet = bullet.instance()
		new_bullet.position = position
		new_bullet.direction = position.direction_to(get_global_mouse_position())
		get_tree().get_root().add_child(new_bullet)
		
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func take_damage(damage):
	if !$InvincibilityTimer.is_stopped():
		return
	
	current_health = clamp(current_health - damage, 0, max_health)
	emit_signal("health_updated", current_health, max_health)

	if current_health == 0:
		emit_signal("died")
		die()

	else:
		emit_signal("took_damage", damage)
		took_damage(damage)

func took_damage(damage):
	$InvincibilityTimer.start()
	$EffectsAnimationPlayer.play("damaged")
	$EffectsAnimationPlayer.queue("invincible")
	pass

func die():
	LevelManager.reset_level()

func set_input_locked(value : bool):
	input_locked = value

func play_spawn_animation():
	set_input_locked(true)
	$AnimationPlayer.play("spawn")

func play_exit_animation():
	set_input_locked(true)
	$AnimationPlayer.play("exit")

func _on_InvincibilityTimer_timeout():
	$EffectsAnimationPlayer.play("idle")
