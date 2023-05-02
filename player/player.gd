extends RigidBody2D

var saved_velocity = Vector2(0, 0)
var expected_velocity

var ropeLength = 20
var PIECE = preload("res://ropelink.tscn")
var attachedLoad

var paused = false

var isDead = false
var isDying = false
var dyingTime:float = 0

func _ready():
	contact_monitor = true
	max_contacts_reported = 100
	angular_damp = 5 #stop rotation in 0.2s 
	connect("body_entered", on_collision)   
	

func _physics_process(delta):
	if(isDying):
		dyingTime += delta
		if(dyingTime > 3):
			isDead = true
		$Particles.emitting = false
		linear_damp = 99999
		$TextureRect.visible = true
	else:
		var particles = get_node("Particles")
		particles.emitting = false
		if Input.is_action_pressed("Boost"):
			apply_central_force(Vector2(-sin(rotation), cos(rotation)) * -2000)
			particles.emitting = true
			particles.direction = Vector2(-sin(rotation), cos(rotation))
		apply_torque(Input.get_axis("Left", "Right") * 15_000)
		handleCollisions()
		if Input.is_action_pressed("Cargo"):
			dumpCargo()
		handleCargoDistance()

var attached = false
func on_collision(body):
	if body.is_in_group("cargo"):
		call_deferred("handleCargo", body)

func handleCollisions():
	var velocity_change = saved_velocity - linear_velocity
	if(velocity_change.length() > 1500):
		isDying = true
	saved_velocity = linear_velocity

func handleCargo(cargo: RigidBody2D):
	if(!attached && linear_velocity.length() < 1000 && onTopOf(cargo)):
		attached = true
		var parent = self
		for i in ropeLength:
			parent = addPiece(parent, cargo.mass)

		var joint = parent.get_node("ropeconnect/joint")
		cargo.global_position = joint.global_position
		joint.node_a = parent.get_path()
		joint.node_b = cargo.get_path()
		
		attachedLoad = cargo


func addPiece(parent, cargoMass):
	var joint = parent.get_node("ropeconnect/joint")
	var piece = PIECE.instantiate()
	piece.mass = cargoMass
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece

func dumpCargo():
	if(attached):
		attached = false
		var joint: PinJoint2D = self.get_node("ropeconnect/joint")
		var lastJoint = joint
		while(true):
			var joint2 = lastJoint.get_node("ropeconnect/joint")
			if(joint2 == null): break
			else: lastJoint = joint2
		joint.get_children()[0].queue_free()
		lastJoint.node_b = joint.get_path()

func handleCargoDistance():
	if(attached):
		var dist = self.global_transform.origin.distance_to(attachedLoad.global_transform.origin)
		if(dist > 400):
			dumpCargo()

func onTopOf(cargo: RigidBody2D):
	var diff = global_transform.origin - cargo.global_transform.origin
	return (abs((diff).x) < 120 && diff.y < 0) 
