extends Line2D
class_name Line2O
var objects:Array[SpaceObject]

#func _physics_process(delta: float) -> void:
	#points.clear()
	#points.append_array([to_local(objects[0].global_position),to_local(objects[1].global_position)])

func update_line():
	points.clear()
	points.append_array([to_local(objects[0].global_position),to_local(objects[1].global_position)])

	
func _enter_tree() -> void:
	create_line()

func create_line():
	self.width = 5
	self.begin_cap_mode = Line2D.LineCapMode.LINE_CAP_ROUND
	self.default_color = Color.REBECCA_PURPLE
	self.antialiased = true
	self.z_index = 1
	self.points = points
