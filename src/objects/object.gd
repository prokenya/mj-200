class_name SpaceObject
extends Area2D

signal object_connected(object: SpaceObject)
signal signal_strength_updated()
@export var input: Array[SpaceObject]
@export var output: Array[SpaceObject]
@export var max_input_count: int = 1
@export var max_output_count: int = 1
@export var signal_strength: int = 0:
	set(val):
		signal_strength = val
		signal_strength_updated.emit()

@onready var label


func _ready() -> void:
	label = Label.new()
	#label.position = self.global_position
	add_child(label)


func connect_object(object: SpaceObject, inp: bool):
	if inp:
		input.append(object)

	else:
		output.append(object)

	update_connections()
	object_connected.emit(object)


func update_connections(visited: Array[SpaceObject] = []) -> int:
	if self in visited:
		return signal_strength

	visited.append(self)

	var sum := 0
	for connected in input:
		sum += connected.signal_strength

	signal_strength = sum
	show_debug()

	for connected in output:
		connected.update_connections(visited)

	return signal_strength


func show_debug():
	if !label: return
	label.z_index = 255
	label.text = str(signal_strength)
