extends RigidBody2D

func _physics_process(delta):
	if Input.is_action_pressed("Boost"):
		apply_central_force(Vector2(-sin(rotation), cos(rotation)) * -2000)
	angular_velocity = Input.get_axis("Left", "Right") * delta * 200
