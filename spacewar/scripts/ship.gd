extends CharacterBody2D

@export var ship_data: ShipData
@export var rotation_speed = 5

@onready var screen_size = get_viewport().get_visible_rect().size
@onready var ship_sprite = $Sprite2D

func _ready() -> void:
	ship_sprite.texture = ship_data.ship_sprite
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	handle_screen_wrap()
	
func _process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	rotation += direction * rotation_speed * delta
	
	if Input.is_action_pressed("Controller_A"):
		var thrust_vector = Vector2.UP.rotated(rotation)
		var thrust = thrust_vector * ship_data.thrust_power * delta
	
		velocity += thrust
		velocity = velocity.limit_length(ship_data.max_speed)

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
