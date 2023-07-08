extends Panel


@onready var mission_menu_screen_scene: PackedScene = load("res://scenes/mission_menu_screen.tscn")
@onready var new_mission_menu_screen_scene: PackedScene = load("res://scenes/new_mission_menu_screen.tscn")
@onready var exit_menu_screen_scene: PackedScene = load("res://scenes/exit_menu_screen.tscn")


var current_screen: MenuScreen


func beep():
	$AudioStreamPlayer.play()


func set_mission_menu_screen():
	if current_screen != null:
		current_screen.queue_free()
	current_screen = mission_menu_screen_scene.instantiate() as MenuScreen
	current_screen.position = Vector2(8,8)
	add_child(current_screen)


func set_new_mission_menu_screen():
	if current_screen != null:
		current_screen.queue_free()
	current_screen = new_mission_menu_screen_scene.instantiate() as MenuScreen
	current_screen.position = Vector2(8,8)
	add_child(current_screen)


func set_exit_menu_screen():
	if current_screen != null:
		current_screen.queue_free()
	current_screen = exit_menu_screen_scene.instantiate() as MenuScreen
	current_screen.position = Vector2(8,8)
	add_child(current_screen)


func _ready():
	set_mission_menu_screen()

