extends Node2D
class_name MenuScreen


var items: Array[MenuItem]
var current_selection = 0


func beep():
	if get_parent().has_method("beep"):
		get_parent().beep()


func back():
	pass


func choose(n: int):
	pass


func select(n: int):
	if n != current_selection:
		beep()
	
	current_selection = n
	
	for item in items:
		if item.order_number == current_selection:
			item.set_selected(true)
		else:
			item.set_selected(false)
	


func is_menu_item(i: Node) -> bool:
	return true if i is MenuItem else false


func _ready():
	var children = get_children().filter(is_menu_item)
	for child in children:
		items.append(child as MenuItem)
	
	for item in items:
		item.selection.connect(select)
		item.clicked.connect(choose)
	
	select(0)


func _physics_process(_delta):
	if Input.is_action_just_pressed("menu_up"):
		select(max(0, current_selection-1))
	if Input.is_action_just_pressed("menu_left"):
		select(max(0, current_selection-1))
	if Input.is_action_just_pressed("menu_down"):
		select(min(items.size()-1, current_selection+1))
	if Input.is_action_just_pressed("menu_right"):
		select(min(items.size()-1, current_selection+1))
	
	if Input.is_action_just_pressed("menu_select"):
		choose(current_selection)
	if Input.is_action_just_pressed("menu_cancel"):
		back()


