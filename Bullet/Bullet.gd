extends Area2D

export var damage = 1
export var speed = 500
export var friendly = true

var direction = Vector2()

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	_handle_collision(body)

func _on_area_entered(area):
	_handle_collision(area)

func _handle_collision(body):
	var body_group = "enemy" if friendly else "player"
	
	if body.is_in_group("static"):
		queue_free()
	if body.is_in_group(body_group):
		body.take_damage(damage)
		queue_free()