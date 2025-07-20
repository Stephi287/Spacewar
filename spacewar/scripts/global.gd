extends Node2D

var score_p1 = 0
var score_p2 = 0
var unvincible = false
var end = false

func get_reset_pos(player_id) -> Vector2:
	match player_id:
		0: return Vector2(20,20)
		1: return Vector2(300,220)
	return Vector2(0,0)	

func get_winner() -> int:
	if score_p1 == 5:
		return 0
	elif score_p2 == 5:
		return 1
	else:
		return -1



func reset_global():
	score_p1 = 0
	score_p2 = 0
