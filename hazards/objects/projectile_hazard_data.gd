class_name ProjectileHazardData extends Resource


var projectile_packed: PackedScene = preload("res://hazards/objects/projectile_hazard.tscn")

@export var shape: Shape2D
@export var lifetime: float = 5.0
@export var speed: float = 60.0
@export var direction: Vector2
@export var visual_scene: PackedScene
@export var visual_scene_direction: Vector2 = Vector2.DOWN

# TODO: needs visual information to be able to pass into the hazard

func create_hazard_scene () -> ProjectileHazard:
	var projectile_scene: ProjectileHazard = projectile_packed.instantiate()
	projectile_scene.shape = shape
	projectile_scene.lifetime = lifetime
	projectile_scene.direction = direction
	projectile_scene.speed = speed

	# TODO: rotate the "projectile_scene" by some amount determined by "visual_scene_direction" and "direction"

	var visuals: Node2D = visual_scene.instantiate()
	visuals.rotate(visual_scene_direction.angle_to(direction))
	projectile_scene.add_child(visuals)

	return projectile_scene

