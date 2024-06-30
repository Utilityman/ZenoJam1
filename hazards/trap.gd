class_name Trap extends Node2D

@export var initial_delay: float = 0.0
@export_range(0.0, 15.0, 0.1, "or_greater") var interval: float = 0.0

func trigger () -> void:
	pass
