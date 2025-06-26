extends CharacterBody2D

@export var ship_data: ShipData

func _process(delta: float) -> void:
	var velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * delta * 150
