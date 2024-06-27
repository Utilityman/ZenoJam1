class_name Player extends CharacterBody2D

signal reached_goal

@export var can_control: bool = true
@export var torch: Torch:
	set(new_torch):
		torch = new_torch
		if not is_node_ready(): await ready
		left_hand_transform.remote_path = torch.get_path()
@export var speed = 100.0
@export var launch_speed = 200.0 
@export var gravity = 500.0
@export var onTrigger = false;
var last_direction: String = "IdleDown"

# left_hand_transform is really built for just holding the torch
@onready var left_hand_transform: RemoteTransform2D = $LeftHandTransform
@onready var hurt_box: Area2D = $HurtBox

func _ready() -> void:
	hurt_box.area_entered.connect(_on_hurt_box_collision)

func _on_hurt_box_collision (area: Area2D):
	if area is LevelExit and area.is_active:
		reached_goal.emit()
		return

	if area is Hazard:
		# do torch things, if we're holding it
		if torch and torch.is_held:
			drop_torch((self.global_position - area.global_position).normalized())

		# TODO: do other stuff determined by Hazard properties
		# self.hit_stun(hazard.stun_time)
		# self.move_direction(hazard.push_direction)
		# self.move_speed = hazard.move_speed

func drop_torch (direction: Vector2):
	# unset the left_hand transform and set the torch moving 
	left_hand_transform.remote_path = ""
	torch.set_moving(direction)


func _physics_process(_delta: float) -> void:

	# utility to send the torch back to the player
	if get_tree().root.get_meta("dev_mode", false) and Input.is_action_just_pressed("DEV_RESET"):
		torch.is_held = true
		torch = torch

	if can_control: 
		var player_speed: float = speed
		if Input.is_action_pressed("WALK_MODIFIER"): player_speed /= 2.0

		var input: Vector2 = Input.get_vector(&"MOVE_LEFT", &"MOVE_RIGHT", &"MOVE_UP", &"MOVE_DOWN")
		velocity = input * player_speed
		
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

func play_animation (animation: String):
	$AnimationPlayer.play(animation)
	

func _on_pressure_plate_body_exited(body):
	print("Im off the pressure plate")
	onTrigger = false


func _on_pressure_plate_body_entered(body):
	print("im on the pressure plate")
	onTrigger = true
