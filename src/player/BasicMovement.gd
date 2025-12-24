extends RigidBody2D
class_name BasicMovement
@export var speed:float = 5
@export var max_speed:float = 40
var direction:Vector2

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction:
		linear_velocity += clamp(direction * speed,(Vector2(1,1) * -max_speed), Vector2(1,1) * max_speed)
	$dir.global_rotation = linear_velocity.angle() + PI/2
