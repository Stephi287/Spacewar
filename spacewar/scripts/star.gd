class_name Star
extends Area2D

@export var gravity_strength: float = 2000.0

func _on_body_entered(body: Node2D) -> void:
	if body is Ship:
		body.queue_free()
