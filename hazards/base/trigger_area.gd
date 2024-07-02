class_name TriggerArea extends Area2D

signal player_entered
signal player_exited

@export var hazards: Array[Trap]
@export var times_can_activate: int = -1   

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)

func on_body_entered(body: Node2D):
	print("what is up!")
	if body is Player:
		if times_can_activate > 0 or times_can_activate == -1:
			if times_can_activate > 0: times_can_activate -= 1
			for hazard in hazards:
				hazard.trigger()
			player_entered.emit()

func on_body_exited (body: Node2D):
	if body is Player: player_exited.emit()
	

	
	
