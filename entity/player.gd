class_name Player extends CharacterBody2D


@export var speed = 30.0
@export var launch_speed = 200.0 
@export var gravity = 500.0

@onready var torch: Area2D = $Torch

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		torch.position = Vector2.ZERO
		torch.top_level = false
		torch.is_held = true

	var input: Vector2 = Input.get_vector(&"MOVE_LEFT", &"MOVE_RIGHT", &"MOVE_UP", &"MOVE_DOWN")
	velocity = input * speed

	move_and_slide()

func hit (node: Node2D):
	print("Hit by: " + str(node))
	torch.set_moving((self.global_position - node.global_position).normalized())
