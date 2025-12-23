class_name Endgame
extends SpaceObject

@export var target_strength: int = 1


func _ready() -> void:
	super()
	signal_strength_updated.connect(check_condition)


func check_condition():
	if signal_strength == target_strength:
		print("connected")
		G.main.next_world()
