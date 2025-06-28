class_name GameManager
extends Node2D

var win = false

@onready var ui_node = $"../Control"

func _process(_delta: float) -> void:
	match Global.get_winner():
		0:
			ui_node.play_win_animation(0)
			win = true
		
		1:
			ui_node.play_win_animation(1)
			win = true
		-1: 
			pass
	if win:
		if Input.is_action_just_pressed("START"):
			Global.reset_global()
			get_tree().reload_current_scene()
