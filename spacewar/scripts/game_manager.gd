class_name GameManager
extends Node2D

var win_1 = false
var win_2 = false

@onready var ui_node = $"../Control"

func _process(_delta: float) -> void:
	match Global.get_winner():
		0:
			if not win_2:
				ui_node.play_win_animation(0)
				win_1 = true
		
		1:
			if not win_1:
				ui_node.play_win_animation(1)
				win_2 = true
		-1: 
			pass
	if win_1 or win_2:
		if Input.is_action_just_pressed("START"):
			Global.reset_global()
			get_tree().reload_current_scene()
