class_name BaseLevel extends Node2D

var fire_scene: PackedScene = preload("res://levels/components/fire.tscn")
var burning_tiles: Array[Vector2i] = []

@export var level_name: String
@export var next_level: PackedScene
@export var modulate_background: bool = true

@onready var tile_map: TileMap = $TileMap
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var camera: Camera2D = $Camera2D
@onready var player: Player = $Player
@onready var camera_transform: RemoteTransform2D = $Player/CameraTransform
@onready var player_torch: Torch = $PlayerTorch
@onready var exit: LevelExit = $LevelExit
@onready var ui: LevelUI = $%LevelUI

var finished_level: bool = false

func _ready() -> void:
	if modulate_background: canvas_modulate.visible = true

	player.reached_goal.connect(_on_player_reached_goal)
	exit.destroyed.connect(_on_exit_destroyed)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("DEV_MODE_TOGGLE"):
		get_tree().root.set_meta("dev_mode", !get_tree().root.get_meta("dev_mode", false))
		print("Dev Mode Enabled: " + str(get_tree().root.get_meta("dev_mode")))

func _on_player_reached_goal (): 
	if finished_level: return true
	finished_level = true

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
	if next_level:
		get_tree().call_deferred("change_scene_to_packed", next_level)
	else:
		get_tree().reload_current_scene()

func _on_exit_destroyed ():
	if finished_level: return
	finished_level = true

	player.can_control = false
	camera_transform.remote_path = ""
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)

	# adds some of the height of the door to center the camera correctly
	var final_pos: Vector2 = exit.global_position + Vector2(0, -8)
	tween.tween_property(camera, "global_position", final_pos, 1.0)
	tween.tween_property(camera, "zoom", Vector2(5, 5), 0.5)
	tween.tween_callback(_on_finished_gate_transition)

func _on_finished_gate_transition ():
	exit.play_close_animation()
	ui.show_lost_interface()

