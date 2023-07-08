extends Node


const EASY = 1
const MEDIUM = 2
const HARD = 3


signal show_score(sc: int)
signal show_lives(liv: int)
signal show_level(lvl: int)
signal show_message(msg: String)
signal reload_level()


var difficulty = EASY
var score = 0
var level = 1
var lives = 3
var combo_multiplier = 1
var extra_lives = 0


func _on_repeat_level_timer_timeout():
	emit_signal("reload_level")


func _on_next_level_timer_timeout():
	if get_tree().get_nodes_in_group("Asteroid").size() == 0:
		level += 1
		$NextLevelStreamPlayer.play()
		emit_signal("show_level", level)
		emit_signal("reload_level")


func get_level() -> int:
	return level


func get_lives() -> int:
	return lives


func get_score() -> int:
	return score


func set_difficulty(d: int):
	difficulty = d


func get_difficulty() -> int:
	return difficulty


func hit(_pos: Vector2, base_score: int):
	score += base_score * combo_multiplier
	if score > 9999999:
		score = 9999999
	
	if floor(score/5000.0) > extra_lives:
		extra_lives = floor(score/5000.0)
		lives += 1
		if lives <= 5:
			emit_signal("show_lives", lives)
			$GainLiveStreamPlayer.play()
		else:
			lives = 5
	
	if (combo_multiplier >= 2):
		emit_signal("show_message", "x%d" %combo_multiplier)
		$ComboBonusStreamPlayer.play()
	emit_signal("show_score", score)
	combo_multiplier += 1 
	
	$NextLevelTimer.start() #spr w srodku funkcji/slotu


func missed():
	combo_multiplier = 1


func shuttle_destroyed():
	lives -= 1
	emit_signal("show_lives", lives)
	emit_signal("show_message", "R.I.P.")
	$LostLiveStreamPlayer.play()
	$RepeatLevelTimer.start()


func reset():
	score = 0
	lives = 3
	level = 1
	extra_lives = 0
	combo_multiplier = 1
	
	emit_signal("show_score", score)
	emit_signal("show_lives", lives)
	emit_signal("show_level", level)
	

