extends CharacterBody2D


var resolution: Vector2


func _ready():
	resolution = get_viewport_rect().size
	


func _physics_process(delta):
	position += velocity * delta
	
	if global_position.x < 0 or global_position.x > resolution.x:
		Score.missed()
		queue_free()
	if global_position.y < 0 or global_position.y > resolution.y:
		Score.missed()
		queue_free()
	
