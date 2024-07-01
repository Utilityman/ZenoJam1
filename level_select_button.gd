class_name LevelSelectButton extends Button

@export var level_to_load: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed ():
	if level_to_load: SceneTransition.change_scene(level_to_load)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
