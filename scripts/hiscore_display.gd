extends VBoxContainer
class_name HiscoreDisplay


var entry_scene: PackedScene


func _ready():
	entry_scene = load("res://scenes/hiscore_entry_display.tscn")
	
	for i in HiscoreData.SIZE:
		var entry = entry_scene.instantiate() as HiscoreEntryDisplay
		add_child(entry)
		entry.name_label.text = HiscoreData.hiscore_table[i].get("name")
		entry.score_label.text = "%07d" %HiscoreData.hiscore_table[i].get("score")
		if HiscoreData.hiscore_table[i].get("difficulty") == Score.EASY:
			entry.difficulty_label.text = "EASY"
		if HiscoreData.hiscore_table[i].get("difficulty") == Score.MEDIUM:
			entry.difficulty_label.text = "MEDIUM"
		if HiscoreData.hiscore_table[i].get("difficulty") == Score.HARD:
			entry.difficulty_label.text = "HARD"
	
