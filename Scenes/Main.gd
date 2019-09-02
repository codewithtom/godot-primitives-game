extends Node2D

export var first_level = "Level1"

func _ready():
	LevelManager.change_level(first_level)