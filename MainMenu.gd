extends ColorRect

var arr = []
var callArr = [loadLevel1, loadLevel2, loadLevel3, loadLevel4, loadLevel5, loadLevel6, loadLevel7, loadLevel8, loadLevel9, loadLevel10, loadLevel11, loadLevel12, loadLevel13, loadLevel14, loadLevel15]

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	arr.resize(11)
	for i in 11:
		var lvl = i + 1
		arr[i] = find_child(str(lvl)) 
		arr[i].text = str(lvl)
		arr[i].pressed.connect(callArr[i])
		var button: Button = arr[i]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in 11:
		if(Global.arr[i]):
			arr[i].text = "✔"
	
func loadLevel(lvl):
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Level" + str(lvl) + ".tscn")
	
func loadLevel1():
	loadLevel(1)
func loadLevel2():
	loadLevel(2)
func loadLevel3():
	loadLevel(3)
func loadLevel4():
	loadLevel(4)
func loadLevel5():
	loadLevel(5)
func loadLevel6():
	loadLevel(6)
func loadLevel7():
	loadLevel(7)
func loadLevel8():
	loadLevel(8)
func loadLevel9():
	loadLevel(9)
func loadLevel10():
	loadLevel(10)
func loadLevel11():
	loadLevel(11)
func loadLevel12():
	loadLevel(12)
func loadLevel13():
	loadLevel(13)
func loadLevel14():
	loadLevel(14)
func loadLevel15():
	loadLevel(15)
