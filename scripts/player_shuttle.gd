extends CharacterBody2D
class_name PlayerShuttle


const MAX_ACCELERATION = Vector2(0,-64)
const ROTATION_SPEED = 180
const SHOT_SPEED = 480


var acceleration = Vector2.ZERO
var resolution: Vector2
var shot_scene: PackedScene
var blow_scene: PackedScene


func blowup():
	var blow = blow_scene.instantiate() as CPUParticles2D
	blow.global_position = global_position
	owner.add_child(blow)
	
	#Input.start_joy_vibration(0, 0.0, 1.0, 1.5)
	
	queue_free()
	Score.shuttle_destroyed()


func shoot():
	$AudioStreamPlayer2D.play()
	
	var shot = shot_scene.instantiate() as CharacterBody2D
	shot.rotation = rotation
	shot.velocity = Vector2(0, -SHOT_SPEED).rotated(rotation)
	shot.global_position = global_position + Vector2(0,-9).rotated(rotation)
	owner.add_child(shot)
	


func _ready():
	resolution = get_viewport_rect().size
	shot_scene = load("res://scenes/shot.tscn")
	blow_scene = load("res://scenes/blow.tscn")


func _physics_process(delta):
	position += velocity * delta
	
	velocity += acceleration * delta
	
	if global_position.x < 0:
		global_position.x = resolution.x
	if global_position.x > resolution.x:
		global_position.x = 0
	
	if global_position.y < 0:
		global_position.y = resolution.y
	if global_position.y > resolution.y:
		global_position.y = 0
	
	acceleration = (Input.get_action_strength("accelerate") * MAX_ACCELERATION).rotated(rotation)
	var is_engine_on = (acceleration != Vector2.ZERO)
	$CPUParticles2DLeft.emitting = is_engine_on
	$CPUParticles2DRight.emitting = is_engine_on
	
	rotation_degrees += (Input.get_action_strength("turn_right")-Input.get_action_strength("turn_left")) * ROTATION_SPEED * delta
	if Input.is_action_just_pressed("shoot"):
		shoot()
	

