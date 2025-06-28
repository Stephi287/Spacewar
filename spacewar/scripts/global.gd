extends Node2D

var score_p1 = 0
var score_p2 = 0

func add_point(player_id):
	match player_id:
		0: score_p1 += 1
		1: score_p2 += 1

func get_reset_pos(player_id) -> Vector2:
	match player_id:
		0: return Vector2(30,30)
		1: return Vector2(180,210)
	return Vector2(0,0)	

func get_winner() -> int:
	if score_p1 == 5:
		return 0
	elif score_p2 == 5:
		return 1
	else:
		return -1
