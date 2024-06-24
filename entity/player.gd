class_name Player extends CharacterBody2D


@export var torch: Torch:
	set(new_torch):
		torch = new_torch
		if not is_node_ready(): await ready
		left_hand_transform.remote_path = torch.get_path()
@export var speed = 30.0
@export var launch_speed = 200.0 
@export var gravity = 500.0
var last_direction: String = "IdleDown"

# left_hand_transform is really built for just holding the torch
@onready var left_hand_transform: RemoteTransform2D = $LeftHandTransform
@onready var hurt_box: Area2D = $HurtBox


func _ready() -> void:
	hurt_box.area_entered.connect(_on_hurt_box_collision)

func _on_hurt_box_collision (area: Area2D):
	if torch and torch.is_held:
		# unset the left_hand transform and set the torch moving 
		left_hand_transform.remote_path = ""
		torch.set_moving((self.global_position - area.global_position).normalized())


func _physics_process(_delta: float) -> void:
	var input: Vector2 = Input.get_vector(&"MOVE_LEFT", &"MOVE_RIGHT", &"MOVE_UP", &"MOVE_DOWN")
	velocity = input * speed
	
	animate()
	move_and_slide()

func animate():
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
	
