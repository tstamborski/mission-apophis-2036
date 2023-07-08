extends CanvasLayer


func _on_set_score(score: int):
	$ScoreContainer/Label.text = "%07d" %score

func _on_set_lives(lives: int):
	if lives < 0:
		lives = 0
	
	var sprites = $LivesContainer.get_children() as Array[AnimatedSprite2D]
	if sprites.size() == 0:
		return
	
	var visible_count = 0
	for sprite in sprites:
		if sprite.visible:
			visible_count += 1
	
	if visible_count > lives:
		while visible_count != lives:
			sprites[visible_count-1].play("blinking")
			visible_count -= 1
		$LivesTimer.start()
	if visible_count < lives:
		if lives <= 5:
			while visible_count != lives:
				sprites[visible_count].visible = true
				sprites[visible_count].stop()
				visible_count += 1
		else:
			for sprite in sprites:
				sprite.visible = true
				sprite.stop()


func _on_set_message(msg: String):
	$MessageContainer/Label.text = msg
	$AnimationPlayer.play("message_blink")
	$MessageTimer.start()
	


func _on_set_level(lvl: int):
	_on_set_message("STAGE %d" %lvl)
	
	var medals = $MedalContainer.get_children() as Array[AnimatedSprite2D]
	var medals_count = 0
	for medal in medals:
		if medal.visible:
			medals_count += 1
	
	var needed = floor(lvl/3.0)
	if medals_count > needed:
		while medals_count != needed:
			medals[medals_count-1].visible = false
			medals_count -= 1
	if medals_count < needed:
		if needed <= 5:
			while medals_count != needed:
				medals[medals_count].visible = true
				medals_count += 1
		else:
			for medal in medals:
				medal.visible = true


func _on_lives_timer_timeout():
	var sprites = $LivesContainer.get_children() as Array[AnimatedSprite2D]
	for sprite in sprites:
		if sprite.is_playing():
			sprite.visible = false


func _on_message_timer_timeout():
	$MessageContainer/Label.text = ""
	$AnimationPlayer.stop()


func _ready():
	$LivesContainer/Sprite4.visible = false
	$LivesContainer/Sprite3.visible = false
	$LivesContainer/Sprite2.visible = false
	$LivesContainer/Sprite1.visible = false
	
	for sprite in $MedalContainer.get_children() as Array[AnimatedSprite2D]:
		sprite.play("default")
		sprite.visible = false
	
	$LivesTimer.timeout.connect(_on_lives_timer_timeout)
	$MessageTimer.timeout.connect(_on_message_timer_timeout)
	
	Score.show_level.connect(_on_set_level)
	Score.show_score.connect(_on_set_score)
	Score.show_lives.connect(_on_set_lives)
	Score.show_message.connect(_on_set_message)
	

