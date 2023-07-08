extends Node2D


func set_gold_count(count: int):
	$GoldLabel.text = "x%d" %count


func set_silver_count(count: int):
	$SilverLabel.text = "x%d" %count


func set_bronze_count(count: int):
	$BronzeLabel.text = "x%d" %count


func _ready():
	set_gold_count(HiscoreData.medals["Gold"])
	set_silver_count(HiscoreData.medals["Silver"])
	set_bronze_count(HiscoreData.medals["Bronze"])
	
	$GoldAnimatedSprite2D.play("default")
	$SilverAnimatedSprite2D.play("default")
	$BronzeAnimatedSprite2D.play("default")
	

