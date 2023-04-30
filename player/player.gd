extends RigidBody2D

var saved_velocity = Vector2(0, 0)
var expected_velocity

var ropeLength = 15
var PIECE = preload("res://ropelink.tscn")

var scene = self.get_parent()

var paused = false

func _ready():
	contact_monitor = true
	max_contacts_reported = 100
	angular_damp = 5 #stop rotation in 0.2s 
	connect("body_entered", on_collision)   
	

func _physics_process(delta):
	if Input.is_action_pressed("Boost"):
		apply_central_force(Vector2(-sin(rotation), cos(rotation)) * -2000)
	apply_torque(Input.get_axis("Left", "Right") * 15_000)
	handleCollisions()
	if Input.is_action_pressed("Cargo"):
		dumpCargo()

var attached = false
func on_collision(body):
	if body.is_in_group("cargo"):
		call_deferred("handleCargo", body)
		#handleCargo(body)

func handleCollisions():
	var velocity_change = saved_velocity - linear_velocity
	if(velocity_change.length() > 1500):
		print("dead, collision speed: ", velocity_change.length())
	saved_velocity = linear_velocity

func handleCargo(cargo: RigidBody2D):
	if(!attached && linear_velocity.length() < 1000):
		attached = true
		var parent = self
		for i in ropeLength:
			parent = addPiece(parent)

		var joint = parent.get_node("ropeconnect/joint")
		cargo.global_position = joint.global_position
		joint.add_child(cargo)
		joint.node_a = parent.get_path()
		joint.node_b = cargo.get_path()


func addPiece(parent):
	var joint = parent.get_node("ropeconnect/joint")
	var piece = PIECE.instantiate()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece

func dumpCargo():
	if(attached):
		attached = false
		var joint: PinJoint2D = self.get_node("ropeconnect/joint")
		joint.get_children()[0].queue_free()
