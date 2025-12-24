class_name Endgame
extends SpaceObject

@export var target_strength: int = 1

var checked:bool = false

func _ready() -> void :
	super()
	signal_strength_updated.connect(check_condition)

func check_condition():
	if signal_strength == target_strength:
		if checked:return
		G.main.next_world()
		checked = true
