class_name ProjectileHazardData extends Resource


var projectile_packed: PackedScene = preload("res://hazards/objects/projectile_hazard.tscn")

@export var shape: Shape2D
@export var lifetime: float = 5.0
@export var speed: float = 60.0
@export var direction: Vector2
@export var visual_scene: PackedScene
@export var visual_scene_direction: Vector2 = Vector2.DOWN

func create_hazard_scene () -> ProjectileHazard:
	var projectile_scene: ProjectileHazard = projectile_packed.instantiate()
	projectile_scene.shape = shape
	projectile_scene.lifetime = lifetime
	projectile_scene.direction = direction
	projectile_scene.speed = speed

	var visuals: Node2D = visual_scene.instantiate()
	visuals.rotate(visual_scene_direction.angle_to(direction))
	projectile_scene.add_child(visuals)

	return projectile_scene

