extends RigidBody2D

var saved_velocity = Vector2(0, 0)
var expected_velocity

var ropeLength = 15
var PIECE = preload("res://ropelink.tscn")
var lastrope

func _ready():
	contact_monitor = true
	max_contacts_reported = 100
	angular_damp = 5 #stop rotation in 0.2s 
	connect("body_entered", on_collision)   
	
	var parent = self
	for i in ropeLength:
		parent = addPiece(parent, i)
	lastrope = parent

func _physics_process(delta):
	if Input.is_action_pressed("Boost"):
		apply_central_force(Vector2(-sin(rotation), cos(rotation)) * -2000)
	apply_torque(Input.get_axis("Left", "Right") * 15_000)
	handleCollisions()

var attached = false
func on_collision(body):
	if body.is_in_group("cargo"):
		if(!attached):
			print("handling cargo")
			attached = true
			handleCargo(body)
	pass

func handleCollisions():
	var velocity_change = saved_velocity - linear_velocity
	if(velocity_change.length() > 1500):
		print("collision: ", velocity_change.length())
	saved_velocity = linear_velocity

func handleCargo(body):
	var joint = lastrope.get_node("ropeconnect/joint")
	joint.add_child(body)
	joint.node_a = lastrope.get_path()
	joint.node_b = body.get_path()
	body.position = joint.position

func addPiece(parent, i):
	print(i)
	var joint = parent.get_node("ropeconnect/joint")
	var piece = PIECE.instantiate()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece
