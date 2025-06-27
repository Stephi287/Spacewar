extends CharacterBody2D

@export var ship_data: ShipData
@export var rotation_speed = 5
@export var player_id: int = 0

@onready var screen_size = get_viewport().get_visible_rect().size
@onready var ship_sprite = $Sprite2D

func _ready() -> void:
	ship_sprite.texture = ship_data.ship_sprite
	
func _physics_process(delta: float) -> void:
	var rotate_left = "Controller_%d_LEFT" % player_id
	var rotate_right = "Controller_%d_RIGHT" % player_id
	var thrust_action = "Controller_%d_A" % player_id
	
	var direction = Input.get_axis(rotate_left, rotate_right)
	rotation += direction * rotation_speed * delta
	
	if Input.is_action_pressed(thrust_action):
		var thrust_vector = Vector2.UP.rotated(rotation)
		var thrust = thrust_vector * ship_data.thrust_power * delta
	
		velocity += thrust
		velocity = velocity.limit_length(ship_data.max_speed)
		
	move_and_slide()
	handle_screen_wrap()
	
func _process(delta: float) -> void:
	pass

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
