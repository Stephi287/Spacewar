class_name Projectile
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Ship and body.player_id != origin_player_id:
		Global.add_point(origin_player_id)
		body.position = Global.get_reset_pos(body.player_id)
		queue_free()

@export var speed = 400.0

var direction = Vector2.ZERO
var origin_player_id: int = -1

@onready var screen_size = get_viewport().get_visible_rect().size

func _process(delta: float) -> void:
	position += direction * speed * delta
	_out_of_screen()

func _out_of_screen():
	if position.x < 0 or position.x > screen_size.x:
		queue_free()

	if position.y < 0 or position.y > screen_size.y:
		queue_free()
