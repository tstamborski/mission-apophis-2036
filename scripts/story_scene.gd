extends Node2D


func proceed():
	get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")


func _physics_process(_delta):
	if Input.is_action_just_pressed("menu_cancel"):
		proceed()
	if Input.is_action_just_pressed("menu_select"):
		proceed()
	if Input.is_action_just_pressed("left_click"):
		proceed()
	
