class_name LevelUI extends Control


@onready var lost_ui: Control = $LostUI
@onready var retry_button: Button = $%RetryButton
@onready var main_menu_button: Button = $%MainMenuButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lost_ui.visible = false
	lost_ui.modulate = Color(255, 255, 255, 0)
	retry_button.pressed.connect(_on_retry)
	main_menu_button.pressed.connect(_on_main_menu)

func _on_retry ():
	get_tree().reload_current_scene()

func _on_main_menu ():
	get_tree().change_scene_to_file("res://main.tscn")

func show_lost_interface ():
	var tween: Tween = get_tree().create_tween()
	lost_ui.visible = true
	tween.tween_property(lost_ui, "modulate", Color(0xffffffff), 2.5)