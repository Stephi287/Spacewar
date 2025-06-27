extends Node2D

var score_p1 = 0
var score_p2 = 0

func add_point(player_id):
	match player_id:
		0: score_p1 += 1
		1: score_p2 += 1
