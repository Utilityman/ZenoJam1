class_name _Global extends Node

signal orb_obtained

@export var player_has_orb: bool = false

func obtain_orb ():
	player_has_orb = true
	orb_obtained.emit()