class_name LevelExit extends Area2D

signal destroyed

@export var is_active: bool = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	area_entered.connect(_on_area_entered)
 
func _on_area_entered (area: Area2D):
	if area is Fire and is_active: 
		destroyed.emit()
		animation_player.play("CLOSE")
		is_active = false