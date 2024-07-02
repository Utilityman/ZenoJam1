class_name Credits extends Control

var main_menu_scene: PackedScene = preload("res://main.tscn")

@onready var return_button: Button = $%ReturnButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)

func _on_return_button_pressed ():
	SceneTransition.change_scene(main_menu_scene)
