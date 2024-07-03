class_name IntroLevel extends BaseLevel

@onready var first_label = $FirstLabel

func _ready() -> void:
	super._ready()
	var tween = get_tree().create_tween()
	tween.tween_property(first_label, "modulate", Color(255, 255, 255, 0), 2.5)

	player.reached_goal.connect(_change_music)

func _change_music ():
	if Global.music_player.stream != level_music:
		Global.play_music(level_music)
