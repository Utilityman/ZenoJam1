class_name Main extends Control

@export var first_level: PackedScene
@export var josh_level: PackedScene

@onready var play_button: Button = $%PlayButton
@onready var josh_button: Button = $%JoshLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	josh_button.pressed.connect(_on_josh_button_pressed)

func _on_play_button_pressed ():
	get_tree().change_scene_to_packed(first_level)

func _on_josh_button_pressed ():
	get_tree().change_scene_to_packed(josh_level)