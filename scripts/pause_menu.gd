extends Panel


var menu_item_list: Array[Node]
var current_selection: int = 0


func resume():
	hide()
	Input.action_release("shoot")
	Input.action_release("accelerate")
	Input.action_release("pause")


func restart():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game_scene.tscn")


func main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")


func exit():
	get_tree().quit()


func choose(n: int):
	if n == current_selection:
		$SwitchStreamPlayer.play()
		
		if n == 0:
			resume()
		if n == 1:
			restart()
		if n == 2:
			main_menu()
		if n == 3:
			exit()


func select(n: int):
	if n != current_selection:
		$SwitchStreamPlayer.play()
	
	current_selection = n
	
	for i in menu_item_list.size():
		if i == n:
			(menu_item_list[i] as MenuItem).set_selected(true)
		else:
			(menu_item_list[i] as MenuItem).set_selected(false)


func _ready():
	menu_item_list = [$ResumeMenuItem, $RestartMenuItem, $MainMenuMenuItem, $ExitMenuItem]
	($ResumeMenuItem as MenuItem).set_selected(true)


func _physics_process(_delta):
	if Input.is_action_just_pressed("menu_up"):
		select(max(0, current_selection-1))
	if Input.is_action_just_pressed("menu_down"):
		select(min(3, current_selection+1))
	if Input.is_action_just_pressed("menu_select"):
		choose(current_selection)
	if Input.is_action_just_pressed("menu_cancel"):
		resume()

