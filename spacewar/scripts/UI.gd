extends Control

@onready var score_label = $Label

func _process(_delta: float) -> void:
	var score_p1 = Global.score_p1
	var score_p2 = Global.score_p2
	score_label.text = str(score_p1,":",score_p2)
