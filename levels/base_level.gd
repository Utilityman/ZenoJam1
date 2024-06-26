class_name BaseLevel extends Node2D

var fire_scene: PackedScene = preload("res://levels/components/fire.tscn")
var burning_tiles: Array[Vector2i] = []

@export var next_level: PackedScene

@onready var tile_map: TileMap = $TileMap
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var player: Player = $Player
@onready var player_torch: Torch = $PlayerTorch
@onready var exit: LevelExit = $LevelExit


func _ready() -> void:
	canvas_modulate.visible = true

	player.reached_goal.connect(_on_player_reached_goal)
	exit.destroyed.connect(_on_exit_destroyed)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("DEV_MODE_TOGGLE"):
		get_tree().root.set_meta("dev_mode", !get_tree().root.get_meta("dev_mode", false))
		print("Dev Mode Enabled: " + str(get_tree().root.get_meta("dev_mode")))

func _on_player_reached_goal (): 
	player.drop_torch(Vector2(0, 1))
	player.can_control = false
	player.play_animation("WalkUp")
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(player, "modulate", Color.hex(0x0f0f26), 3)
	tween.tween_property(player, "global_position", exit.global_position, 3)

	# something something screen transition
	# tween.chain().tween_property(get_viewport().get_texture().get_data()
	
	tween.chain().tween_callback(_switch_level)

func _switch_level ():
	get_tree().call_deferred("change_scene_to_packed", next_level)

func _on_exit_destroyed ():
	# get_tree().paused = true
	pass
