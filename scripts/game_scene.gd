extends Node2D

#@onready var game_field_scene = load("res://scenes/game_field.tscn") as PackedScene

func game_field_reload():
	if Score.get_lives() <= 0:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().change_scene_to_file("res://scenes/game_over_scene.tscn")
		return
	
	var game_field_scene: PackedScene
	var hard_lvl = Score.get_difficulty()
	if hard_lvl == Score.EASY:
		game_field_scene = load("res://scenes/game_field_easy.tscn")
	else:
		if hard_lvl == Score.MEDIUM:
			game_field_scene = load("res://scenes/game_field_medium.tscn")
		else:
			game_field_scene = load("res://scenes/game_field_hard.tscn")
	
	var game_field = get_tree().get_first_node_in_group("GameField") as Node2D
	if game_field != null:
		game_field.queue_free()
	add_child(game_field_scene.instantiate())
	


func pause():
	$SwitchStreamPlayer.play()
	get_tree().paused = true
	$PauseLayer/PauseMenu.show()
	Input.action_release("menu_cancel")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func unpause():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	get_tree().paused = false


func _ready():
	Score.reload_level.connect(game_field_reload)
	Score.reset()
	
	$PauseLayer/PauseMenu.hide()
	
	game_field_reload()


func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause()


func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		pause()
	

