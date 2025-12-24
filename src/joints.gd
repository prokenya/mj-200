extends Node2D

@export var scope: Area2D
@export var check_cast: RayCast2D
@export var area:Area2D

var connection_state: bool = false
var cut_state: bool = false
var cut_start_position: Vector2

@onready var node_a: SpaceObject
@onready var node_b: SpaceObject


func _physics_process(delta: float) -> void :
	var mouse_pos = get_global_mouse_position()
	scope.global_position = mouse_pos
	if connection_state or cut_state:
		queue_redraw()


func _input(event: InputEvent) -> void :

	if event.is_action_pressed("lmb"):
		var areas = scope.get_overlapping_areas()

		var object: SpaceObject
		for obj in areas:
			if obj is SpaceObject:
				object = obj
				break
		if !object: reset();return


		
		if node_a:
			if node_a == object:return
			node_b = object
			create_line()
			reset()
			return

		node_a = object
		connection_state = true

	if event.is_action_pressed("rmb"):
		if connection_state:
			reset()
			return
		if cut_state:
			area.get_child(0).shape.a = cut_start_position
			area.get_child(0).shape.b = scope.global_position
			await get_tree().physics_frame
			await get_tree().physics_frame
			var bodies = area.get_overlapping_bodies()
			#var wire = get_wire_intersection(cut_start_position, scope.global_position)
			for body in bodies:
				body.get_parent().cut()
				
			reset()
			return
		cut_state = true
		cut_start_position = get_global_mouse_position()



func reset():
	connection_state = false
	cut_state = false
	node_a = null
	node_b = null
	queue_redraw()


func create_line():
	if node_a in node_b.output: return
	if node_b.max_input_count <= node_b.input.size(): return
	if node_a.max_output_count <= node_a.output.size(): return

	var dir: = (node_b.global_position - node_a.global_position).normalized()
	if get_wire_intersection(node_a.global_position + dir * 12.0, node_b.global_position - dir * 12.0): return

	node_b.connect_object(node_a, true)
	node_a.connect_object(node_b, false)
	var wire = Wire.new()
	wire.objects.append_array([node_a, node_b])
	node_a.add_child(wire)


func get_wire_intersection(start: Vector2, end: Vector2) -> Node2D:
	check_cast.global_position = start
	check_cast.target_position = check_cast.to_local(end)
	check_cast.force_raycast_update()
	if check_cast.is_colliding():
		var collider: Node2D = check_cast.get_collider()
		print(collider.name)
		return collider.get_parent()
	return null


func _draw() -> void :
	if connection_state:
		draw_line(node_a.global_position, scope.global_position, Color.BLUE, 10, true)
	if cut_state:
		draw_line(cut_start_position, scope.global_position, Color.RED, 10, true)
