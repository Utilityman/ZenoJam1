class_name BaseLevel extends Node2D

var fire_scene: PackedScene = preload("res://entity/fire.tscn")
var burning_tiles: Array[Vector2i] = []

@export var next_level: PackedScene

@onready var tile_map: TileMap = $TileMap
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var player: Player = $Player
@onready var exit: LevelExit = $LevelExit

func _ready() -> void:
	canvas_modulate.visible = true

	player.reached_goal.connect(_on_player_reached_goal)
	exit.destroyed.connect(_on_exit_destroyed)

func _on_player_reached_goal (): 
	get_tree().call_deferred("change_scene_to_packed", next_level)

func _on_exit_destroyed ():
	# get_tree().paused = true
	pass
