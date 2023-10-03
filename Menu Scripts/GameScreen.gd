extends Control

const casteDisplayScene = preload("res://GameObjects/CasteDisplay.tscn")

var turnNumber = 1
var rebellionPoints = 0
var securityPoints = 0
var economyPoints = 0

var gameOverTurn = 20
var rebellionThreshold = -1000

var randGenerator = RandomNumberGenerator.new()

func _ready():
	
	
	if GameData.GetWarStatus() == "War Ended":
		#we just surrendered, apply penalties
		rebellionPoints += GameData.GetTurnsAtWar() * -100
		economyPoints += GameData.GetTurnsAtWar() * -1000
		GameData.SetWarStatus("No War") 
		GameData.SetTurnsAtWar(0)
	
	DisplayCastes()
	PopulateInformationLabels()

			

			
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
			economyPointHelper -= caste.GetApproval() * caste.GetLimitedness()
			
			var points = caste.GetApproval() * caste.GetLimitedness()
			securityPoints += points
				
		elif caste.GetRulingClass() == false:
			economyPointHelper += caste.GetApproval() * caste.GetLimitedness()
			
			var points = caste.GetApproval() * caste.GetLimitedness()
			rebellionPoints += points
		
		
	if economyPointHelper > 0:
		#ruling class doesn't pay taxes, working class does
		#econ points is lower class limitedness - ruling class limitedness * 1000
		economyPoints += economyPointHelper * 1000
	
func GetIfWarContinues():
	var chance = 0
	#get the current turns at war and use that to calculate a chance of it ending.
	if GameData.GetTurnsAtWar() <= 5:
		#one in twenty chance it ends
		chance = randGenerator.randi_range(1,20)
		if chance <= 1:
			#war ends, you win. Else, it continues
			HandleWarVictory()
			
		
	elif GameData.GetTurnsAtWar() <= 10:
		#one in ten chance it ends
		chance = randGenerator.randi_range(1,10)
		if chance <= 1:
			#war ends, you win. Else, it continues
			HandleWarVictory()
			
	elif GameData.GetTurnsAtWar() <= 20:
		#one in five chance it ends
		chance = randGenerator.randi_range(1,5)
		if chance <= 1:
			#war ends, you win. Else, it continues
			HandleWarVictory()
			
func HandleWarVictory():
	var warTurns = GameData.GetTurnsAtWar()
	var warWinnings = 0
	
	GameData.SetWarStatus("No War")
	GameData.SetTurnsAtWar(0)
	
	#win money based on how long you were at war. Somewhat random
	#also, winning a war stop any rebellion
	
	if warTurns <= 5:
		#between 5000 and 10000
		warWinnings = randGenerator.randi_range(5000,10000)
		economyPoints += warWinnings
		rebellionPoints = 0
	if warTurns <= 10:
		#between 10000 and 20000
		warWinnings = randGenerator.randi_range(10000,20000)
		economyPoints += warWinnings
		rebellionPoints = 0
	if warTurns <= 20:
		#between 20000 and 30000
		warWinnings = randGenerator.randi_range(20000,30000)
		economyPoints += warWinnings
		rebellionPoints = 0
	
	
	
		

func PopulateInformationLabels():
	$RebellionPointsLabel.text = "Rebellion Points: " + str(rebellionPoints)
	$TurnCountLabel.text = "Turn: " +str(turnNumber)
	$SecurityPointsLabel.text = "Security Points: " + str(securityPoints)
	$EconomyPointsLabel.text = "Economy Points: " + str(economyPoints)

func _on_create_caste_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	get_tree().get_current_scene().ready
	
	
	


func _on_end_turn_pressed():
	if len(GameData.castes) > 1:
		#at least 2 castes
		turnNumber += 1
		
		if GameData.GetWarStatus() == "War":
			GameData.SetTurnsAtWar(GameData.GetTurnsAtWar() + 1)
			
			securityPoints += GameData.GetTurnsAtWar() * -500
			
			#get if war end
			GetIfWarContinues()
		
		CalculateRebellionAndSecurityPoints()
		
		
		PopulateInformationLabels()
		
		
	if rebellionPoints <= rebellionThreshold:
		get_tree().change_scene_to_file("res://Menus/DefeatScreen.tscn")
	elif turnNumber == gameOverTurn:
		get_tree().change_scene_to_file("res://Menus/VictoryScreen.tscn")
		
		
		
		


func _on_war_pressed():
	
	get_tree().change_scene_to_file("res://Menus/WarMenu.tscn")
	
	


func _on_family_pressed():
	get_tree().change_scene_to_file("res://Menus/FamilyMenu.tscn")
