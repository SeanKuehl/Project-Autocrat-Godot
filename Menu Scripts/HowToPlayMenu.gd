extends Control


var textEntries = []
var entriesIndex = 0

var imageList = ["HowToPlaylogo.png", "coin.png", "eye.png", "fist.png", "CasteMenu.png", "CasteMenu.png", "CasteMenu.png", "war.png", "child.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	textEntries = GameData.LoadHowToPlayFromFile()
	SetEntry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func SetEntry():
	$ExplanationLabel.text = textEntries[entriesIndex]
	$ExplanationPicture.texture = load("res://assets/HowToPlay/Images/"+imageList[entriesIndex])


func _on_next_button_pressed():
	var max = len(textEntries) -1
	
	if entriesIndex < max:
		entriesIndex += 1
	
	SetEntry()
	


func _on_last_button_pressed():
	var min = 0
	
	if entriesIndex > min:
		entriesIndex -= 1
		
	SetEntry()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
