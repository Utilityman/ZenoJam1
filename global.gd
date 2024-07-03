class_name _Global extends Node

signal orb_obtained

@export var orb_modulate: Color = Color(0x28ff28ff)
@export var player_has_orb: bool = false

@onready var music_player: AudioStreamPlayer2D = $MusicPlayer

func obtain_orb ():
	player_has_orb = true
	orb_obtained.emit()

func fade_label (label: Label):
	fade_label_with_times(label, 1.0, 2.5)

func fade_label_with_times (label: Label, fade_in: float, fade_out: float):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(label, "modulate", Color(0xFFFFFFFF), fade_in)
	tween.tween_property(label, "modulate", Color(0xFFFFFF00), fade_out)

func play_music (music_stream: AudioStream):
	if not music_player.playing: _start_music(music_stream)
	else:
		var tween: Tween = get_tree().create_tween()

		tween.tween_property(music_player, "volume_db", -80, 1.0)
		tween.tween_callback(_start_music.bind(music_stream))

func _start_music (music_stream: AudioStream):
	music_player.stop()
	music_player.stream = music_stream
	music_player.play()

	var tween: Tween = get_tree().create_tween()
	tween.tween_property(music_player, "volume_db", -10, 0.5)

func stop_music ():
	music_player.stop()