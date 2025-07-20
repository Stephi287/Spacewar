extends Node2D

@onready var hit_sound = $HitSound

func play_hit_sound():
	hit_sound.play()
