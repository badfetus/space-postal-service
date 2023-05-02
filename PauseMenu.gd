extends ColorRect

@onready var resume: Button = find_child("Resume")
@onready var quit: Button = find_child("Quit")
@onready var restart: Button = find_child("Restart")

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	resume.pressed.connect(unpause)
	quit.pressed.connect(leave)
	restart.pressed.connect(doRestart)
	

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
	self.rotation = -get_parent().rotation
	get_tree().paused = true
	self.visible = true
	
func leave():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	
func doRestart():
	unpause()
	get_tree().change_scene_to_file("res://" +get_parent().get_parent().name + ".tscn")
