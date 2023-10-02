extends Control


var econPoints = 0
var secPoints = 0

var startWarThreshold = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = GameData.GetWarTransfer()
	secPoints = temp[0]
	econPoints = temp[1]
	
	if GameData.activeWar == true:
		$DeclareWarButton.disabled = true
	else:
		$SurrenderButton.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_declare_war_button_pressed():
	#you need at least 1000 security points to declare war
	#war will eat up an increasing amount(500) of security points each turn
	#if you win a war you earn approval and money
	#if you run out of security points you are conquered
	if GameData.activeWar == false and secPoints >= startWarThreshold:
		GameData.activeWar = true
	
	
	
	


func _on_surrender_button_pressed():
	#if you surrender you lose money and approval
	#more for longer you've been at war
	
	pass # Replace with function body.


func _on_back_button_pressed():
	GameData.SetWarTransfer(secPoints,econPoints)
	get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")
	
	
