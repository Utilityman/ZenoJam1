class_name IntervalProjectileSpawner extends Node2D

# TODO: this needs to export a whole sort of texture / animated thing (another packed scene??)
# 	 	(the default icon.svg is unfortunately not good enough)
@export_range(0.0, 15.0, 0.1, "or_greater") var interval: float = 0.0

# TODO: this almost needs to take a resource that builds the emit scene instead?
@export var projectile_data: ProjectileHazardData

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	if interval > 0:
		timer.wait_time = interval
		timer.start()
		timer.timeout.connect(spawn_projectile)

func spawn_projectile():
	var projectile: ProjectileHazard = projectile_data.create_hazard_scene()
	add_child(projectile)
