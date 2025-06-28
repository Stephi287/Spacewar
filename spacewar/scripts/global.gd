extends Node2D

var score_p1 = 0
var score_p2 = 0
var unvincible = false

func add_point(player_id):
	match player_id:
		0: score_p1 += 1
		1: score_p2 += 1

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

func make_unvincible(ship):
	set_deferred("ship_collision.disabled", true)
	unvincible = true
	var timer = Timer.new()
	add_child(timer)
	timer.start(1.5)
	await timer.timeout
	if ship:
		ship.ship_collision.disabled = false
	unvincible = false

func reset_global():
	score_p1 = 0
	score_p2 = 0
