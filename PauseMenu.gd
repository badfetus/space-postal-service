extends ColorRect

@onready var resume: Button = find_child("Resume")
@onready var quit: Button = find_child("Quit")

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	resume.pressed.connect(unpause)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if(get_tree().paused):
			unpause()
		else:
			pause()

func unpause():
	get_tree().paused = false
	self.visible = false
	
func pause():
	get_tree().paused = true
	self.visible = true
