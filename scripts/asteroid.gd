extends CharacterBody2D
class_name Asteroid


@export var points: int = 5
@export var blow_scene: PackedScene


@onready var rotation_speed: float = 90.0 if randi_range(0,1) == 1 else -90.0
@onready var resolution: Vector2 = get_viewport_rect().size


func create_child_asteroids():
	pass

func create_blow():
	if blow_scene == null:
		return
	
	var blow = blow_scene.instantiate() as CPUParticles2D
	blow.global_position = global_position
	get_parent().add_child(blow)
	

func blowup():
	create_blow()
	create_child_asteroids()
	
	queue_free()
	Score.hit(global_position, points)
	


func _physics_process(delta):
	rotation_degrees += rotation_speed * delta
	
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		var collider = collision.get_collider() as CharacterBody2D
		if collider.is_in_group("Shot"):
			collider.queue_free()
			blowup()
		else:
			if collider.is_in_group("Player"):
				position += velocity * delta
				if collider.has_method("blowup"):
					collider.blowup()
			else:
				velocity = velocity.rotated(
					collider.velocity.angle_to(global_position)
				)
	
	if global_position.x < 0:
		global_position.x = resolution.x
	if global_position.x > resolution.x:
		global_position.x = 0
	
	if global_position.y < 0:
		global_position.y = resolution.y
	if global_position.y > resolution.y:
		global_position.y = 0
	

