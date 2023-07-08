extends Node2D


func proceed():
	$AudioStreamPlayer.stop()
	
	var gold = 0
	var silver = 0
	var bronze = 0
	var lvl = Score.get_level()
	if lvl >= 3:
		bronze = 1
	if lvl >= 6:
		silver = 1
	if lvl >= 9:
		gold = 1
	if lvl >= 12:
		gold = 2
	if lvl >= 15:
		gold = 3
	HiscoreData.add_new_medals(gold, silver, bronze)
	HiscoreData.save_medals()
	
	if HiscoreData.is_new_hiscore(Score.get_score()):
		get_tree().change_scene_to_file("res://scenes/enter_name_scene.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")


func _physics_process(_delta):
	if Input.is_action_just_pressed("menu_select"):
		proceed()
	if Input.is_action_just_pressed("menu_cancel"):
		proceed()
	if Input.is_action_just_pressed("left_click"):
		proceed()

