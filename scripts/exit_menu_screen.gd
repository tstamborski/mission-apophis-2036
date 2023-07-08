extends MenuScreen


func back():
	if get_parent().has_method("set_mission_menu_screen"):
		get_parent().set_mission_menu_screen()
	


func choose(n: int):
	if n != current_selection:
		return
	
	beep()
	
	if n == 0:
		get_tree().quit()
	if n == 1:
		back()

