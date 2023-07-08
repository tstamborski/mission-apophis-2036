extends Asteroid


@onready var asteroid12_scene: PackedScene = load("res://scenes/asteroid_12.tscn")
@onready var goldasteroid12_scene: PackedScene = load("res://scenes/gold_asteroid_12.tscn")


func create_child_asteroids():
	const LUCKY_RANGE = 299
	var asteroid_new1
	var asteroid_new2
	
	if randi_range(0, LUCKY_RANGE) == 0:
		asteroid_new1 = goldasteroid12_scene.instantiate() as CharacterBody2D
	else:
		asteroid_new1 = asteroid12_scene.instantiate() as CharacterBody2D
	if randi_range(0, LUCKY_RANGE) == 0:
		asteroid_new2 = goldasteroid12_scene.instantiate() as CharacterBody2D
	else:
		asteroid_new2 = asteroid12_scene.instantiate() as CharacterBody2D
	asteroid_new1.velocity = velocity.rotated(-PI/2)
	asteroid_new2.velocity = velocity.rotated(PI/2)
	asteroid_new1.global_position = global_position + Vector2(0,-8).rotated(
		asteroid_new1.velocity.angle_to(Vector2.UP)
	)
	asteroid_new2.global_position = global_position + Vector2(0,-8).rotated(
		asteroid_new2.velocity.angle_to(Vector2.UP)
	)
	get_parent().add_child(asteroid_new1)
	get_parent().add_child(asteroid_new2)


func _ready():
	velocity = Vector2(0,-20).rotated(randf_range(0,TAU))
	

