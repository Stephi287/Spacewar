class_name GameManager
extends Node2D

func _process(delta: float) -> void:
	match Global.get_winner():
		0: print("Spieler 1 gewinnt")
		1: print("Spieler 2 gewinnt")
		-1: pass
		
