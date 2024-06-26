class_name Main extends Control

@export var first_level: PackedScene

@onready var play_button: Button = $%PlayButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)

func _on_play_button_pressed ():
	get_tree().change_scene_to_packed(first_level)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
