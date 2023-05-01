extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var l = get_node("zoneL").hasCargo
	var m = get_node("zoneM").hasCargo
	var h = get_node("zoneH").hasCargo
	if($player.isDead): 
		var newscene = get_tree().change_scene_to_file("res://Demo.tscn")
