extends Node2D


func _on_timer_timeout():
	$RedFirework.position = Vector2(randi_range(0,320), randi_range(0,200))
	$GreenFirework.position = Vector2(randi_range(0,320), randi_range(0,200))
	$BlueFirework.position = Vector2(randi_range(0,320), randi_range(0,200))
	$BlueFirework2.position = Vector2(randi_range(0,320), randi_range(0,200))
	


func _on_line_edit_text_submitted(new_text):
	HiscoreData.add_new_hiscore(
		new_text, Score.get_score(),
		Score.get_difficulty(), Score.get_level()
	)
	HiscoreData.save_hiscore()
	
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/hiscore_scene.tscn")
	


func _ready():
	$Panel/LineEdit.grab_focus()


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()

