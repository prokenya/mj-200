extends Node2D

@export var scope:Area2D
var connection_state:bool = false
@onready var node_a:SpaceObject
@onready var node_b:SpaceObject

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("lmb"):
		var areas = scope.get_overlapping_areas()
		
		var object:SpaceObject
		for obj in areas:
			if obj is SpaceObject:
				object = obj
				break
		if !object:reset();return
		
		print(object.name)
		
		if node_a:
			node_b = object
			create_line()
			reset()
			return
			
		node_a = object
		connection_state = true

func reset():
	connection_state = false
	node_a = null
	node_b = null
	queue_redraw()
	

func create_line():
	if node_a in node_b.output:return
	if node_b.max_input_count <= node_b.input.size():return
	if node_a.max_output_count <= node_a.output.size():return
	
	node_b.connect_object(node_a,true)
	node_a.connect_object(node_b,false)
	var line = Line2O.new()
	line.objects.append_array([node_a,node_b])
	node_a.add_child(line)


func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	scope.global_position = mouse_pos
	if connection_state:
		queue_redraw()

func _draw() -> void:
	if connection_state:
		draw_line(node_a.global_position,scope.global_position,Color.RED,10,true)
