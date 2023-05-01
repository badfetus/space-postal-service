extends Area2D

var hasCargo = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "cargoH":
			var cargo: RigidBody2D = body
			if cargo.linear_velocity.length() < 10:
				hasCargo = true
				return
	hasCargo = false
