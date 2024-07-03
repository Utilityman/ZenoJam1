class_name TreasureHoard extends BaseLevel

var final_scene: PackedScene = load("res://core/final_screen/final_screen.tscn")

@onready var orb: OrbOfGoblinKind = $OrbOfGoblinKind
@onready var orb_area: Area2D = $OrbOfGoblinKind/OrbArea

@onready var can_it_be_label: Label = $CanItBeLabel
@onready var can_it_be_collision: Area2D = $CanItBeCollision
var has_shown_can_it_be_label: bool = false

@onready var orb_of_goblin_kind_label: Label = $OrbOfGoblinKindLabel
@onready var orb_of_goblin_kind_collision: Area2D = $OrbOfGoblinKindCollision
var has_show_orb_text: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	orb_area.body_entered.connect(_on_orb_area_entered)
	Global.orb_obtained.connect(_on_orb_obtained)
	can_it_be_collision.body_entered.connect(_show_can_it_be)
	can_it_be_label.modulate = Color(0xFFFFFF00)

	orb_of_goblin_kind_collision.body_entered.connect(_show_orb_text)
	orb_of_goblin_kind_label.modulate = Color(0xFFFFFF00)

func _show_can_it_be(node: Node2D):
	if node is Player and not has_shown_can_it_be_label:
		has_shown_can_it_be_label = true
		Global.fade_label(can_it_be_label)

func _show_orb_text (node: Node2D):
	if node is Player and not has_show_orb_text:
		has_show_orb_text = true
		Global.fade_label(orb_of_goblin_kind_label)

func _on_orb_obtained ():
	await get_tree().create_timer(2.0).timeout
	SceneTransition.change_scene(final_scene)


func _on_orb_area_entered (body: Node2D):
	if body is Player:
		orb.take_orb(body)