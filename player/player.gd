extends RigidBody2D

var saved_velocity

func _ready():
	connect("body_entered", on_collision)

func _physics_process(delta):
	if Input.is_action_pressed("Boost"):
		apply_central_force(Vector2(-sin(rotation), cos(rotation)) * -2000)
	angular_velocity = Input.get_axis("Left", "Right") * delta * 200
	saved_velocity = linear_velocity

func on_collision(body):
	if body.is_in_group("cargo"):
		print("this is cargo")
	
	#Fix diz shiz. Make good
	if saved_velocity.length_squared() > 500000:
		print("I did it! I died in a crash")
