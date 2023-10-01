extends Control

const casteDisplayScene = preload("res://GameObjects/CasteDisplay.tscn")

var turnNumber = 1
var rebellionPoints = 0
var securityPoints = 0
var economyPoints = 0

var gameOverTurn = 20
var rebellionThreshold = -1000

func _ready():
	
	DisplayCastes()
	$RebellionPointsLabel.text = "Rebellion Points: " + str(rebellionPoints)
	$TurnCountLabel.text = "Turn: " +str(turnNumber)
	$securityPointsLabel.text = "Security Points: " + str(securityPoints)
	$EconomyPointsLabel.text = "Economy Points: " + str(economyPoints)

			
func DisplayCastes():
	
	#display all castes in the list
	var casteApprovalIndex = 0
	var casteLocation = 100
	
	if len(GameData.castes) <= 0:
		#nothing to show, do nothing
		pass
	else:
		#display castes in CasteDisplay objects
		pass
		
		for caste in GameData.castes:
			
			var newCaste = casteDisplayScene.instantiate()
			newCaste.global_position = Vector2(100,casteLocation)
			casteLocation += 200
			newCaste.DisplayCaste(caste)
			add_child(newCaste)
			
		

			
		
func CalculateRebellionAndSecurityPoints():
	var economyPointHelper = 0
	
	for caste in GameData.castes:
		
		if caste.GetRulingClass() == true:
			economyPointHelper -= caste.GetLimitedness()
			if caste.GetApproval() >= 20:
				var points = caste.GetApproval() * caste.GetLimitedness()
				securityPoints += points
				
		elif caste.GetRulingClass() == false:
			economyPointHelper += caste.GetLimitedness()
			if caste.GetApproval() <= -20:
				var points = caste.GetApproval() * caste.GetLimitedness()
				rebellionPoints += points
		
		
	if economyPointHelper > 0:
		#ruling class doesn't pay taxes, working class does
		#econ points is lower class limitedness - ruling class limitedness * 1000
		economyPoints += economyPointHelper * 1000
	
		


func _on_create_caste_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	get_tree().get_current_scene().ready
	
	


func _on_end_turn_pressed():
	if len(GameData.castes) > 1:
		#at least 2 castes
		turnNumber += 1
		CalculateRebellionAndSecurityPoints()
		$RebellionPointsLabel.text = "Rebellion Points: " + str(rebellionPoints)
		$TurnCountLabel.text = "Turn: " +str(turnNumber)
		$securityPointsLabel.text = "Security Points: " + str(securityPoints)
		$EconomyPointsLabel.text = "Economy Points: " + str(economyPoints)
		
	if rebellionPoints <= rebellionThreshold:
		get_tree().change_scene_to_file("res://Menus/DefeatScreen.tscn")
	elif turnNumber == gameOverTurn:
		get_tree().change_scene_to_file("res://Menus/VictoryScreen.tscn")
		
		
		
		
