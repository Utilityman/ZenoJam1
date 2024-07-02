extends Node2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate", Color(255, 255, 255, 0), 3.0)
