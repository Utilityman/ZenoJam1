class_name ProjectileHazardData extends Resource


var projectile_packed: PackedScene = preload("res://hazards/objects/projectile_hazard.tscn")

@export var shape: Shape2D
@export var lifetime: float = 5.0
@export var speed: float = 60.0
@export var direction: Vector2
@export var visual_scene: PackedScene

# TODO: needs visual information to be able to pass into the hazard

func create_hazard_scene () -> ProjectileHazard:
    var projectile_scene: ProjectileHazard = projectile_packed.instantiate()
    projectile_scene.shape = shape
    projectile_scene.lifetime = lifetime
    projectile_scene.direction = direction
    projectile_scene.speed = speed
    var visuals = visual_scene.instantiate()
    projectile_scene.add_child(visuals)

    return projectile_scene

