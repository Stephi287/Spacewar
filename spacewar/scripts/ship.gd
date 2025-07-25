class_name Ship
extends CharacterBody2D

@export var ship_data: ShipData
@export var rotation_speed = 5
@export var player_id: int = 0
@export var projectile_scene: PackedScene

var _fire_timer = 0.0

@onready var screen_size = get_viewport().get_visible_rect().size
@onready var ship_sprite = $Sprite2D
@onready var ship_collision = $CollisionShape2D
@onready var ship_particle = $CPUParticles2D
@onready var laser_sound = $LaserSound
@onready var explsion_sound = $ExplosionSound
@onready var thrust_sound = $ThrustSound
@onready var explosion_animation = $ExplosionAnimation
@onready var star = get_tree().current_scene.get_node("Star")  # oder anderer Pfad

func _ready() -> void:
	ship_sprite.texture = ship_data.ship_sprite
	
func _physics_process(delta: float) -> void:
	_fire_timer -= delta
	
	var rotate_left = "Controller_%d_LEFT" % player_id
	var rotate_right = "Controller_%d_RIGHT" % player_id
	var thrust_action = "Controller_%d_A" % player_id
	var fire = "Controller_%d_X" % player_id
	
	var direction = Input.get_axis(rotate_left, rotate_right)
	rotation += direction * rotation_speed * delta
	
	if Input.is_action_pressed(thrust_action):
		var thrust_vector = Vector2.UP.rotated(rotation)
		var thrust = thrust_vector * ship_data.thrust_power * delta
	
		velocity += thrust
		velocity = velocity.limit_length(ship_data.max_speed)
		
		ship_particle.direction = thrust_vector * -1
		ship_particle.emitting = true
	else:
		ship_particle.emitting = false
		#thrust_sound.playing = false
	if Input.is_action_just_pressed(thrust_action):
		thrust_sound.play()
	
	if Input.is_action_pressed(fire) and _fire_timer <= 0:
		_fire_timer = ship_data.fire_rate
		fire_projectile()
		laser_sound.play()
		
	move_and_slide()
	handle_screen_wrap()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is Ship:
			_on_collision_with_ship(collision.get_collider())
	
	apply_gravity_from_star(delta)

func _on_collision_with_ship(other_ship):
	#Global.make_unvincible(self)
	#Global.make_unvincible(other_ship)
	
	Input.start_joy_vibration(player_id,1,1,0.5)
	ship_sprite.visible = false
	await dead(position, player_id, self)
	position = Global.get_reset_pos(player_id)
	ship_sprite.visible = true
	velocity = Vector2(0,0)

	Input.start_joy_vibration(player_id,0,1,0.5)
	await dead(other_ship.position, other_ship.player_id, other_ship)
	other_ship.position = Global.get_reset_pos(other_ship.player_id)
	other_ship.velocity = Vector2(0,0)
	
	explsion_sound.play()
	
func fire_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.position = position
	projectile.rotation = rotation
	projectile.direction = Vector2.UP.rotated(rotation)
	projectile.origin_player_id = player_id  # 👈 WICHTIG!
	get_tree().current_scene.add_child(projectile)

func handle_screen_wrap():
	# Wrap horizontal
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0

	# Wrap vertical
	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0

func apply_gravity_from_star(delta: float) -> void:
	if star == null:
		return

	var to_star = star.global_position - global_position
	var distance = to_star.length()

	# Sicherheitsabstand
	if distance < 10:
		return

	var gravity_force = to_star.normalized() * star.gravity_strength / (distance * distance)
	velocity += gravity_force * delta

func dead(pos, id, body):
	explosion_animation.visible = true
	explosion_animation.position = pos
	make_unvincible(body)
	if id == 0:
		explosion_animation.play("explosion")
		await explosion_animation.animation_finished
		explosion_animation.visible = false
	else:
		explosion_animation.play("explosion2")
		await explosion_animation.animation_finished
		explosion_animation.visible = false


func make_unvincible(ship):
	set_deferred("ship_collision.disabled", true)
	Global.unvincible = true
	var timer = Timer.new()
	add_child(timer)
	timer.start(1.5)
	await timer.timeout
	if ship:
		ship.ship_collision.disabled = false
	Global.unvincible = false
