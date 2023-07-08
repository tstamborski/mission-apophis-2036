extends MenuScreen


func choose(n: int):
	if n != current_selection:
		return
	
	beep()
	
	if n == 0:
		if get_parent().has_method("set_new_mission_menu_screen"):
			get_parent().set_new_mission_menu_screen()
	if n == 1:
		get_tree().change_scene_to_file("res://scenes/hiscore_scene.tscn")
	if n == 2:
		if get_parent().has_method("set_exit_menu_screen"):
			get_parent().set_exit_menu_screen()

