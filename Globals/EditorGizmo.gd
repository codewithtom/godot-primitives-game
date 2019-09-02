tool

extends Node2D

func _draw():
	if Engine.editor_hint:
		draw_circle(position, 5, Color.green)