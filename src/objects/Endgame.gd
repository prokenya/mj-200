class_name Endgame
extends SpaceObject

@export var target_strength: int = 1


func _ready() -> void:
	super()
	object_connected.connect(func(obj): check_condition())


func check_condition():
	if signal_strength == target_strength:
		print("connected")
