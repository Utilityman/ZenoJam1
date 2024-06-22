class_name IntervalProjectileSpawner extends Node2D

# TODO: this needs to export a whole sort of texture / animated thing (another packed scene??)
# 	 	(the default icon.svg is unfortunately not good enough)
@export var shape: Shape2D
@export_range(0.1, 15.0, 0.1, "or_greater") var interval: float = 1.5

# TODO: this almost needs to take a resource that builds the emit scene instead?
@export var projectile_data: ProjectileHazardData

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	collision_shape.shape = shape
	timer.wait_time = interval
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var projectile: ProjectileHazard = projectile_data.create_hazard_scene()
	add_child(projectile)



