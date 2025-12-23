class_name Wire
extends Line2D

var body: StaticBody2D
var collision_shape: CollisionShape2D
var shape: SegmentShape2D

@onready var objects: Array[SpaceObject]


func _ready() -> void:
	create_line()

#func _physics_process(delta: float) -> void:
	#update_line()


func update_line():
	points.clear()

	points = [to_local(objects[0].global_position), to_local(objects[1].global_position)]


func create_line():
	self.width = 5
	self.begin_cap_mode = Line2D.LineCapMode.LINE_CAP_ROUND
	self.default_color = Color.REBECCA_PURPLE
	self.antialiased = true
	self.z_index = 1
	gradient = Gradient.new()

	update_line()
	update_collision()


func update_collision():
	if !body:
		body = StaticBody2D.new()
		body.set_collision_layer_value(1, false)
		body.set_collision_layer_value(5, true)
		add_child(body)
	if !collision_shape:
		collision_shape = CollisionShape2D.new()
		body.add_child(collision_shape)
	if !shape:
		shape = SegmentShape2D.new()
		collision_shape.shape = shape
	shape.set_deferred("a", points[0])
	shape.set_deferred("b", points[1])


func cut():
	objects[0].output.erase(objects[1])
	objects[1].input.erase(objects[0])

	for object in objects:
		object.update_connections()

	queue_free()
