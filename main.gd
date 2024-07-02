class_name Main extends Control

@export var first_level: PackedScene
@export var josh_level: PackedScene

@onready var torch: Torch = $Torch
@onready var title_label: Label = $%TitleLabel
@onready var play_button: Button = $%PlayButton
@onready var level_button: Button = $%LevelSelect
@onready var level_return: Button = $%LevelReturn

@onready var core_menu: Control = $%CoreMenu
@onready var level_menu: Control = $%LevelMenu

var OFFSET: Vector2 = Vector2(0, 8)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	play_button.pressed.connect(_on_play_button_pressed)
	level_button.pressed.connect(_on_level_select_pressed)
	level_return.pressed.connect(_on_level_return_pressed)

func _on_play_button_pressed ():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SceneTransition.change_scene(first_level)

func _on_level_select_pressed ():
	core_menu.visible = false
	level_menu.visible = true

func _on_level_return_pressed ():
	core_menu.visible = true
	level_menu.visible = false

func _process(_delta: float) -> void:
	var viewport_center: Vector2 = get_viewport_rect().size / 2.0
	var mouse_pos: Vector2 = get_local_mouse_position()

	var x_offset: int = (int) (((viewport_center.x - mouse_pos.x) / 10) - OFFSET.x)
	var y_offset: int = (int) (((viewport_center.y - mouse_pos.y) / 10) - OFFSET.y)
	title_label.add_theme_constant_override("shadow_offset_x", x_offset)
	title_label.add_theme_constant_override("shadow_offset_y", y_offset)

	torch.global_position = get_local_mouse_position() - Vector2(-4, -12)
