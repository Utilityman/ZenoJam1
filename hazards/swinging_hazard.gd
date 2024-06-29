extends Area2D

@onready var _follow :PathFollow2D = get_parent()
@export var player: Player
var _speed :float = 120.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	self.body_entered.connect(on_body_entered)
	#$AnimationPlayer.play("fly")

func _physics_process(delta):
	_follow.set_progress(_follow.get_progress() + _speed * delta)

func on_body_entered(body: Node2D):
	player.drop_torch(direction)
	

	
