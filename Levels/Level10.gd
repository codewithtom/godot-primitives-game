extends Node

var countdown = 3

func _on_Timer_timeout():
	countdown = countdown - 1
	
	match countdown:
		2:
			$Label.text = "2"
		1:
			$Label.text = "1"
		0:
			$Label.text = "This is hell!"
			$TemporaryWalls.queue_free()
	
	if countdown == 0:
		$Timer.stop()
