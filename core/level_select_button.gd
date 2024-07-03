class_name LevelSelectButton extends Button

@export var level_to_load: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_button_pressed)
	if not level_to_load:
		self.disabled = true

func _on_button_pressed ():
	Global.stop_music()
	if level_to_load: 
		SceneTransition.change_scene(level_to_load)

