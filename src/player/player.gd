extends BasicMovement
class_name Player

@export var particles: GPUParticles2D

func _physics_process(delta: float) -> void :
    super (delta)
    if direction:
        particles.global_rotation = direction.angle() + PI
        particles.emitting = true
    else:
        particles.emitting = false
