extends Control

@onready var score_label = $Label
@onready var win_animation = $"../AnimationPlayer"
@onready var win_label = $"WinName"
@onready var info_label = $"RestartInfo"
var win_color = [Color("eb4953"), Color("0096d1")]
var win = false

func _process(_delta: float) -> void:
	var score_p1 = Global.score_p1
	var score_p2 = Global.score_p2
	score_label.text = str(score_p1,":",score_p2)

func play_win_animation(id: int):
	win_label.text = str("Player ", id+1, " wins!")
	win_label.add_theme_color_override("font_color", win_color[id])
	win_animation.play("WinNameBlink")
	info_label.visible = true
	win = true
