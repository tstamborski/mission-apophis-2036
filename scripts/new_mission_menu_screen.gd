extends MenuScreen


func back():
	if get_parent().has_method("set_mission_menu_screen"):
		get_parent().set_mission_menu_screen()
	


func proceed(hardlvl: int):
	Score.set_difficulty(hardlvl)
	get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
	


func choose(n: int):
	if n != current_selection:
		return
	
	beep()
	
	if n == 0:
		proceed(Score.EASY)
	if n == 1:
		proceed(Score.MEDIUM)
	if n == 2:
		proceed(Score.HARD)
	

