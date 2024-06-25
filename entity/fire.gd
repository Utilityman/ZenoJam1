class_name Fire extends Node2D

signal spread

@export var strength: float = 1.0

@onready var spread_timer: Timer = $SpreadTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spread_timer.timeout.connect(_on_spread)


func _on_spread ():
	spread.emit(self.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

