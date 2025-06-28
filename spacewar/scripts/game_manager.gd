class_name GameManager
extends Node2D

@onready var win_animation = $"../AnimationPlayer"
@onready var win_label = $"../Control/WinName"
var win_color = [Color("eb4953"), Color("0096d1")]
var win = false

func _process(_delta: float) -> void:
	match Global.get_winner():
		0: _win_animation(0)
		1: _win_animation(1)
		-1: pass
	if win:
		if Input.is_action_just_pressed("START"):
			Global.reset_global()
			get_tree().reload_current_scene()

func _win_animation(id: int):
	win_label.text = str("Player ", id+1, " wins!")
	win_label.add_theme_color_override("font_color", win_color[id])
	win_animation.play("WinNameBlink")
	win = true
