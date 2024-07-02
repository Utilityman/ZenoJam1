class_name OrbOfGoblinKind extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("floating")

func take_orb (position: Vector2):
	pass