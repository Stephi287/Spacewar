extends CharacterBody2D

@export var ship_data: ShipData
@export var rotation_speed = 3

func _process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	rotation += direction * rotation_speed * delta
	
	if Input.is_action_pressed("Controller_A"):
		var thrust_vector = Vector2.UP.rotated(rotation)
		var velocity = thrust_vector * ship_data.thrust_power * delta
	
		position += velocity
