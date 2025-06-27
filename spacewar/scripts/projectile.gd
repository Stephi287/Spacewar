class_name Projectile
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Ship and body.player_id != _origin_player_id:
		body.queue_free()
		queue_free()

@export var speed = 400.0

var _direction = Vector2.ZERO
var _origin_player_id: int = -1

@onready var screen_size = get_viewport().get_visible_rect().size

func _process(delta: float) -> void:
	position += _direction * speed * delta
	_out_of_screen()

func _out_of_screen():
	if position.x < 0 or position.x > screen_size.x:
		queue_free()

	if position.y < 0 or position.y > screen_size.y:
		queue_free()
