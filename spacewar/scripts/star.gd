class_name Star
extends Area2D

@export var gravity_strength: float = 2000.0

@onready var star_sound = $StarSound

func _on_body_entered(body: Node2D) -> void:
	if body is Ship:
		body.position = Global.get_reset_pos(body.player_id)
		body.velocity = Vector2(0,0)
		Global.make_unvincible(body)
		star_sound.play()
		if body.player_id == 0:
			Global.add_point(1)
		elif body.player_id == 1:
			Global.add_point(0)
