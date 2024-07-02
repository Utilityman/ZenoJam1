class_name LevelUI extends Control


@onready var root_ui: Control = $RootUI

@onready var resume_button: Button = $%ResumeButton
@onready var retry_button: Button = $%RetryButton
@onready var main_menu_button: Button = $%MainMenuButton

@onready var lost_label: Label = $%LostLabel
@onready var paused_label: Label = $%PausedLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root_ui.visible = false
	root_ui.modulate = Color(255, 255, 255, 0)

	retry_button.pressed.connect(_on_retry)
	main_menu_button.pressed.connect(_on_main_menu)
	resume_button.pressed.connect(_on_resume)

func _on_retry ():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu ():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")

func _on_resume ():
	get_tree().paused = false
	root_ui.modulate = Color(0xffff00)
	root_ui.visible = false
	paused_label.visible = false
	resume_button.visible = false

func show_lost_interface ():
	lost_label.visible = true
	var tween: Tween = get_tree().create_tween()
	root_ui.visible = true
	tween.tween_property(root_ui, "modulate", Color(0xffffffff), 2.5)

func show_pause_menu ():
	root_ui.modulate = Color(0xffffff)
	root_ui.visible = true
	paused_label.visible = true
	resume_button.visible = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PAUSE"):
		show_pause_menu()
		get_tree().paused = true
