extends ParallaxBackground

@export var scroll_velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Layer0/AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset += scroll_velocity * delta
