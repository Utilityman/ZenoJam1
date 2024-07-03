extends Control

var credits: PackedScene = load("res://core/credits/credits.tscn")

@onready var first_label: Label = $%Label
@onready var second_label: Label = $%Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	first_label.modulate = Color(0xFFFFFF00)
	second_label.modulate = Color(0xFFFFFF00)
	
	get_tree().create_timer(0.5).timeout.connect(_on_first_label)
	get_tree().create_timer(2.0).timeout.connect(_on_second_label)

	get_tree().create_timer(2.0 + 2.0 + 3.0).timeout.connect(_on_complete)

func _on_first_label ():
	Global.fade_label_with_times(first_label, 2.0, 3.0)
	print("Do the first label")

func _on_second_label ():
	print("Do the second label")
	Global.fade_label_with_times(second_label, 2.0, 3.0)

func _on_complete ():
	SceneTransition.change_scene(credits)