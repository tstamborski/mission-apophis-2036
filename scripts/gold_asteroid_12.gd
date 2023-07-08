extends Asteroid

@onready var goldasteroid8_scene: PackedScene = load("res://scenes/gold_asteroid_8.tscn")


func create_child_asteroids():
	var asteroid_new1: CharacterBody2D
	var asteroid_new2: CharacterBody2D
	var asteroid_new3: CharacterBody2D
	
	asteroid_new1 = goldasteroid8_scene.instantiate()
	asteroid_new2 = goldasteroid8_scene.instantiate()
	asteroid_new3 = goldasteroid8_scene.instantiate()
	
	asteroid_new1.velocity = velocity.rotated(-PI/3)
	asteroid_new2.velocity = velocity.rotated(PI/3)
	asteroid_new3.velocity = velocity.rotated(PI)
	
	asteroid_new1.global_position = global_position + Vector2(0,-6).rotated(
		asteroid_new1.velocity.angle_to(Vector2.UP)
	)
	asteroid_new2.global_position = global_position + Vector2(0,-6).rotated(
		asteroid_new2.velocity.angle_to(Vector2.UP)
	)
	asteroid_new3.global_position = global_position + Vector2(0,-6).rotated(
		asteroid_new3.velocity.angle_to(Vector2.UP)
	)
	
	get_parent().add_child(asteroid_new1)
	get_parent().add_child(asteroid_new2)
	get_parent().add_child(asteroid_new3)

