class_name IntervalProjectileSpawner extends Node2D

@export var initial_delay: float = 0.0
@export_range(0.0, 15.0, 0.1, "or_greater") var interval: float = 0.0
@export var projectile_data: ProjectileHazardData

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var spawn_origin: Node2D = $SpawnOrigin

func _ready() -> void:
	if interval > 0:
		timer.wait_time = interval
		timer.start()
		timer.timeout.connect(spawn_projectile)

func spawn_projectile():
	var projectile: ProjectileHazard = projectile_data.create_hazard_scene()
	spawn_origin.add_child(projectile)
