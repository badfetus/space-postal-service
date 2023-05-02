extends Node2D

var timeSinceWin = 0
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$cargoL/CollisionShape2D.scale = Vector2(2.25,2.25)
	var oldscale = $cargoL/Sprite2D.scale
	$cargoL/Sprite2D.scale = Vector2(2.25 * oldscale.x,2.25 * oldscale.y)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(timeSinceWin > 3):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
	
	if(win): 
		timeSinceWin += delta
		$player.get_node("Victory").rotation = -$player.rotation
	else:
		var l = get_node("zoneL").hasCargo
		var m = get_node("zoneM").hasCargo
		var h = get_node("zoneH").hasCargo
		if(l && h && m): 
			win = true
			Global.arr[int(name.substr(5)) - 1]  = true
			$player.get_node("Victory").visible = true
		elif($player.isDead): 
			get_tree().change_scene_to_file("res://" + self.name + ".tscn")
		elif($player.isDying):
			$player.get_node("Death").visible = true
			$player.get_node("Death").rotation = -$player.rotation
