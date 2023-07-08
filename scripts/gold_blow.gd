extends CPUParticles2D


func _ready():
	emitting = true
	$AudioStreamPlayer2D.play()
	

func _on_timer_timeout():
	queue_free()
