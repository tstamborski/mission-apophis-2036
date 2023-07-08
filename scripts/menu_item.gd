extends Label
class_name MenuItem


signal selection(s: int)
signal clicked(n: int)


@export var order_number: int = 0


var selected: bool = false


func set_selected(s: bool):
	selected = s
	$CursorSprite2D.visible = selected


func is_selected() -> bool:
	return selected


func setup_cursor():
	$CursorSprite2D.position = Vector2(text.length()*8, 0)


func _on_mouse_entered():
	emit_signal("selection", order_number)


func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			emit_signal("clicked", order_number)


func _ready():
	$CursorSprite2D.position = Vector2(text.length()*8, 0)
	$CursorSprite2D.visible = selected
	$CursorSprite2D.play("default")
	
	mouse_entered.connect(_on_mouse_entered)
	property_list_changed.connect(setup_cursor)
	gui_input.connect(_on_gui_input)

