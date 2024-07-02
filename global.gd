class_name _Global extends Node

signal orb_obtained

@export var orb_modulate: Color = Color(0x28ff28ff)
@export var player_has_orb: bool = false

func obtain_orb ():
	player_has_orb = true
	orb_obtained.emit()