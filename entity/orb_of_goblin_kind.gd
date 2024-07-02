class_name OrbOfGoblinKind extends StaticBody2D

@onready var orb: Sprite2D = $Orb

var has_orb: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("floating")

func take_orb (destination: Node2D):
	if not has_orb: return 

	has_orb = false
	$AnimationPlayer.play("RESET")
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(orb, "global_position", destination.global_position, 0.1)

	tween.tween_callback(_orb_taken)

func _orb_taken ():
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(orb, "modulate", Color(0xffffff00), 0.3)
	tween.tween_callback(_on_orb_gone)

func _on_orb_gone ():
	Global.obtain_orb()
	orb.visible = false
