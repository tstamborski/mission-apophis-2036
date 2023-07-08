extends Node


const SIZE = 10
const FILE_PATH = "user://hiscore.sav"
const MEDAL_FILE_PATH = "user://medals.sav"


var hiscore_table: Array[Dictionary] = []
var medals: Dictionary = {"Gold": 0, "Silver": 0, "Bronze": 0}


func load() -> bool:
	return load_hiscore() and load_medals()


func load_medals() -> bool:
	var file = FileAccess.open(MEDAL_FILE_PATH, FileAccess.READ)
	if file == null:
		return false
	
	var text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	if json.parse(text) != OK:
		return false
	
	medals = json.data as Dictionary
	return true


func load_hiscore() -> bool:
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	if file == null:
		return false
	
	var text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	if json.parse(text) != OK:
		return false
	
	var data = json.data
	for i in SIZE:
		hiscore_table[i] = data[i] as Dictionary
	return true


func save():
	save_hiscore()
	save_medals()


func save_medals():
	var file = FileAccess.open(MEDAL_FILE_PATH, FileAccess.WRITE)
	if file == null:
		return
	
	var text = JSON.stringify(medals, "\t")
	file.store_string(text)
	file.close()


func save_hiscore():
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file == null:
		return
	
	var text = JSON.stringify(hiscore_table, "\t")
	file.store_string(text)
	file.close()


func is_new_hiscore(score: int) -> bool:
	for i in SIZE:
		if hiscore_table[i].get("score") < score:
			return true
	return false


func get_hiscore_index(score: int) -> int:
	for i in SIZE:
		if hiscore_table[i].get("score") < score:
			return i
	return -1


func add_new_medals(g: int, s: int, b: int):
	medals["Gold"] += g
	medals["Silver"] += s
	medals["Bronze"] += b


func add_new_hiscore(name: String, score: int, difficulty: int, level: int):
	var index = get_hiscore_index(score)
	if index < 0:
		return
	
	for i in range(SIZE-1, index, -1):
		hiscore_table[i] = hiscore_table[i-1]
	
	hiscore_table[index] = {"name": name, "score": score, "difficulty": difficulty, "level": level}

func _ready():
	hiscore_table.resize(SIZE)
	var example_entry = {"name": "Player", "score": 2000, "difficulty": Score.EASY, "level": 2}
	for i in SIZE:
		hiscore_table[i] = example_entry
	
	self.load()
