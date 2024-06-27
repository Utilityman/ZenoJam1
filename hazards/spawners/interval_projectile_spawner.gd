class_name IntervalProjectileSpawner extends Trap

@export var projectile_data: ProjectileHazardData

@onready var timer: Timer = $Timer
@onready var spawn_origin: Node2D = $SpawnOrigin

func _ready() -> void:
	if interval > 0:
		if initial_delay > 0: await get_tree().create_timer(initial_delay).timeout
		trigger()
		timer.wait_time = interval
		timer.start()
		timer.timeout.connect(trigger)

func trigger():
	var projectile: ProjectileHazard = projectile_data.create_hazard_scene()
	spawn_origin.call_deferred("add_child", projectile)
