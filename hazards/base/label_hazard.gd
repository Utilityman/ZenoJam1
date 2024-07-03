class_name LabelHazard extends Hazard

@export var label_text: String

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = label_text
	label.modulate = Color(0xFFFFFF00)
	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate", Color(0xFFFFFFFF), 1.0)
	tween.tween_property(label, "modulate", Color(255, 255, 255, 0), 3.0)