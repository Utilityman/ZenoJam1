class_name Player extends CharacterBody2D

@export var speed = 30.0
@export var has_torch: bool = true

@onready var torch: Area2D = $Torch

var hit_direction: Vector2

func _physics_process(_delta: float) -> void:

	var input: Vector2 = Input.get_vector(&"MOVE_LEFT", &"MOVE_RIGHT", &"MOVE_UP", &"MOVE_DOWN")
	velocity = input * speed

	if not has_torch:
		torch.position += hit_direction * _delta * 15.0

	move_and_slide()

func hit (node: Node2D):
	print("Hit by: " + str(node.global_position))
	print("Current location: " + str(self.global_position))
	has_torch = false

	# Hmm somehow have to move the torch around to where it should be. 
	torch.global_position = self.global_position
	# torch.top_level = true
	hit_direction = (self.global_position - node.global_position).normalized()
	print("launch in direction: " + str(hit_direction.normalized()))

