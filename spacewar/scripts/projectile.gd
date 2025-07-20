class_name Projectile
extends Area2D

@onready var game_manager = $"../GameManager"
@onready var sound_manager = $"../SoundManager"

func _on_body_entered(body: Node2D) -> void:
	if body is Ship and body.player_id != origin_player_id:
		if not Global.unvincible:
			game_manager.add_point(origin_player_id)
			Input.start_joy_vibration(body.player_id,0.5,1,0.5)
			body.velocity = Vector2(0,0)
			sound_manager.play_hit_sound()
			
			await body.dead(body.position, body.player_id, body)
			body.position = Global.get_reset_pos(body.player_id)
			#Global.make_unvincible(body)
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
