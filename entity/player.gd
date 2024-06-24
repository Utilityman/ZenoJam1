class_name Player extends CharacterBody2D


@export var speed = 30.0
@export var launch_speed = 200.0 
@export var gravity = 500.0
var last_direction: String = "IdleDown"

@onready var torch: Area2D = $Torch

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		torch.position = Vector2.ZERO
		torch.top_level = false
		torch.is_held = true

	var input: Vector2 = Input.get_vector(&"MOVE_LEFT", &"MOVE_RIGHT", &"MOVE_UP", &"MOVE_DOWN")
	velocity = input * speed
	
	move()
		
		
	move_and_slide()

func hit (node: Node2D):
	print("Hit by: " + str(node))
	torch.set_moving((self.global_position - node.global_position).normalized())


func move():
	if Input.is_action_pressed("MOVE_RIGHT") and Input.is_action_pressed("MOVE_UP"):
		$AnimationPlayer.play("RunUpRight")
		last_direction = "UpRight"
	elif Input.is_action_pressed("MOVE_LEFT") and Input.is_action_pressed("MOVE_UP"):
		$AnimationPlayer.play("RunUpLeft")
		last_direction = "UpLeft"
	elif Input.is_action_pressed("MOVE_RIGHT") and Input.is_action_pressed("MOVE_DOWN"):
		$AnimationPlayer.play("RunDownRight")
		last_direction = "DownRight"
	elif Input.is_action_pressed("MOVE_LEFT") and Input.is_action_pressed("MOVE_DOWN"):
		$AnimationPlayer.play("RunDownLeft")
		last_direction = "DownLeft"
	elif Input.is_action_pressed("MOVE_RIGHT"):
		$AnimationPlayer.play("WalkRight")
		last_direction = "Right"
	elif Input.is_action_pressed("MOVE_LEFT"):
		$AnimationPlayer.play("WalkLeft")
		last_direction = "Left"
	elif Input.is_action_pressed("MOVE_DOWN"):
		$AnimationPlayer.play("WalkForward")
		last_direction = "Down"
	elif Input.is_action_pressed("MOVE_UP"):
		$AnimationPlayer.play("WalkUp")
		last_direction = "Up"
	else:
		match last_direction:
			"Right":
				$AnimationPlayer.play("IdleRight")
			"Left":
				$AnimationPlayer.play("IdleLeft")
			"Down":
				$AnimationPlayer.play("IdleDown")
			"Up":
				$AnimationPlayer.play("IdleUp")
			"UpRight":
				$AnimationPlayer.play("IdleUpRight")
			"UpLeft":
				$AnimationPlayer.play("IdleUpLeft")
			"DownRight":
				$AnimationPlayer.play("IdleDownRight")
			"DownLeft":
				$AnimationPlayer.play("IdleDownLeft")
	
