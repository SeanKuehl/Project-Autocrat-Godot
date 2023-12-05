extends Control

const casteDisplayScene = preload("res://GameObjects/CasteDisplay.tscn")
const turnTransitionScene = preload("res://Menus/TurnTransitionMenu.tscn")

var turnNumber = 1
var rebellionPoints = 0
var securityPoints = 0
var economyPoints = 0



var gameOverTurn = 50
var rebellionThreshold = -5000

var randGenerator = RandomNumberGenerator.new()



func _ready():
	
	var lines = GameData.LoadRandomEventsFromFile()
	RefineLines(lines)
	
	if GameData.turnAndPoints[0] != 0:
		#this to to restore state after change to another scene
		turnNumber = GameData.turnAndPoints[0]
		rebellionPoints = GameData.turnAndPoints[1]
		securityPoints = GameData.turnAndPoints[2]
		economyPoints = GameData.turnAndPoints[3]
		
	
	if GameData.GetWarStatus() == "War Ended":
		#we just surrendered, apply penalties
		rebellionPoints += GameData.GetTurnsAtWar() * -100
		economyPoints += GameData.GetTurnsAtWar() * -1000
		GameData.SetWarStatus("No War") 
		GameData.SetTurnsAtWar(0)
	
	DisplayCastes()
	PopulateInformationLabels()

	$RebellionBar.max_value = abs(rebellionThreshold)
	$RebellionBar.value = abs(rebellionPoints)
	$RebellionThresholdLabel.text = "Rebellion happens at: "+str(rebellionThreshold)
	$CelebrationLabel.text = "Hold celebrations to halve your rebellion points for "+str(GameData.celebrationCost)+" but you'll need to wait 5 turns until you can do it again."
	
	if GameData.celebrationTurnCooldown > 0:
		$CelebrationButton.disabled = true
		GameData.celebrationTurnCooldown -= 1
	
			


func RefineLines(lines):
	var thisEvent = []
	var thisLine = ""
	var counter = 0
	
	for line in lines:
		
		if line == "1":
			thisEvent.append(thisLine)
			counter += 1
		else:
			thisLine = line
			
			
		if counter == 6:
			counter = 0
			GameData.randomEvents.append(thisEvent)
			thisEvent = []
			thisLine = ""
			
	
		


			
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
			securityPoints += points * 100
				
		elif caste.GetRulingClass() == false:
			economyPointHelper += abs(caste.GetApproval() * caste.GetLimitedness())
			
			
			var points = caste.GetApproval() * caste.GetLimitedness()
			rebellionPoints += points
		
	
	if economyPointHelper > 0:
		#ruling class doesn't pay taxes, working class does
		#econ points is lower class limitedness - ruling class limitedness * 1000
		economyPoints += economyPointHelper * 100
	
func GetIfWarContinues():
	var chance = 0
	#get the current turns at war and use that to calculate a chance of it ending.
	if GameData.warDifficulty == "easy":
		#one in twenty chance it ends
		chance = randGenerator.randi_range(1,10)
		if chance <= 1:
			#war ends, you win. Else, it continues
			HandleWarVictory()
			
		
	elif GameData.warDifficulty == "medium":
		#one in ten chance it ends
		chance = randGenerator.randi_range(1,15)
		if chance <= 1:
			#war ends, you win. Else, it continues
			HandleWarVictory()
			
	elif GameData.warDifficulty == "hard":
		#one in five chance it ends
		chance = randGenerator.randi_range(1,20)
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
	
	if GameData.warDifficulty == "easy":
		#between 5000 and 10000
		warWinnings = randGenerator.randi_range(5000,10000)
		economyPoints += warWinnings
		rebellionPoints *= 0.5 #cut rebellion points in half
	if GameData.warDifficulty == "medium":
		#between 10000 and 20000
		warWinnings = randGenerator.randi_range(10000,20000)
		economyPoints += warWinnings
		rebellionPoints *= 0.3	#reduce rebellion points by 70%
	if GameData.warDifficulty == "hard":
		#between 20000 and 30000
		warWinnings = randGenerator.randi_range(20000,30000)
		economyPoints += warWinnings
		rebellionPoints = 0	#remove all rebellion points
	
	

func GenerateFamilyRandomEvents():
	
	
	
	#generate events for spouse
	if GameData.spouseChances != [0,0]:
		GenerateRandomEvent(GameData.spouseChances[0], GameData.spouseChances[1], "spouse")
		
	if GameData.firstChildChances != [0,0]:
		GenerateRandomEvent(GameData.firstChildChances[0], GameData.firstChildChances[1], "first child")
		
	if GameData.secondChildChances != [0,0]:
		GenerateRandomEvent(GameData.secondChildChances[0], GameData.secondChildChances[1], "second child")
		
	if GameData.thirdChildChances != [0,0]:
		GenerateRandomEvent(GameData.thirdChildChances[0], GameData.thirdChildChances[1], "third child")
		
	if GameData.fourthChildChances != [0,0]:
		GenerateRandomEvent(GameData.fourthChildChances[0], GameData.fourthChildChances[1], "fourth child")


func HasHier():
	
	if GameData.firstChildChances != [0,0]:
		return true
		
	if GameData.secondChildChances != [0,0]:
		return true
		
	if GameData.thirdChildChances != [0,0]:
		return true
		
	if GameData.fourthChildChances != [0,0]:
		return true
		
	return false


func CheckForFamilyRevolt():
	
	for member in GameData.familyMemberApprovals:
		
		if member <= -20:
			#trigger a game over
			return true
			
	return false
			

		
func GenerateRandomEvent(chance, multiplier, member):
	var result = randGenerator.randi_range(1,chance)
	var event = randGenerator.randi_range(1,3)
	#todo: instead of print statement, register an event that will appear on the
	#transition screen menu
	if result == 1:
		#there will be an event
		if event == 1:
			#they want to be pampered
			var baseCost = 500
			var fullCost = baseCost * multiplier
			
			var eventText = "Your "+member+" wants to be pampered. They'll need "+str(fullCost)+" economy points spent on them otherwise they'll lose 5 approval."
			GameData.familyEvents.append([member, eventText, event, fullCost, -5])
		elif event == 2:
			#they want to be promoted
			var baseCost = 100
			var fullCost = baseCost * multiplier
			
			var eventText = "Your "+member+" wants to be promoted. They'll need "+str(fullCost)+" rebellion points spent on them otherwise they'll lose 5 approval."
			GameData.familyEvents.append([member, eventText, event, fullCost, -5])
		elif event == 3:
			#they want to be protected
			var baseCost = 100
			var fullCost = baseCost * multiplier
			
			var eventText = "Your "+member+" wants to be protected while they kill someone. They'll need "+str(fullCost)+" security points spent on them otherwise they'll lose 5 approval."
			GameData.familyEvents.append([member, eventText, event, fullCost, -5])
		

func PopulateInformationLabels():
	$RebellionPointsLabel.text = "Rebellion Points: " + str(rebellionPoints)
	$TurnCountLabel.text = "Turn: " +str(turnNumber)
	$SecurityPointsLabel.text = "Security Points: " + str(securityPoints)
	$EconomyPointsLabel.text = "Economy Points: " + str(economyPoints)

func _on_create_caste_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	get_tree().get_current_scene().ready
	
	
func ShowTurnTransitionScreen():
	get_tree().change_scene_to_file("res://Menus/TurnTransitionMenu.tscn")
	
	
			


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
		
		GenerateFamilyRandomEvents()
		
		
		PopulateInformationLabels()
		
	
	
		
	if rebellionPoints <= rebellionThreshold:
		get_tree().change_scene_to_file("res://Menus/DefeatScreen.tscn")
	elif turnNumber == gameOverTurn and HasHier():
		get_tree().change_scene_to_file("res://Menus/VictoryScreen.tscn")
	elif CheckForFamilyRevolt() or HasHier() == false:
		get_tree().change_scene_to_file("res://Menus/DefeatScreen.tscn")
	else:
		
		GameData.turnAndPoints = [turnNumber, rebellionPoints, securityPoints, economyPoints]
		
		
		
		ShowTurnTransitionScreen()
		
		
		
		


func _on_war_pressed():
	GameData.turnAndPoints = [turnNumber, rebellionPoints, securityPoints, economyPoints]
	get_tree().change_scene_to_file("res://Menus/WarMenu.tscn")
	
	


func _on_family_pressed():
	get_tree().change_scene_to_file("res://Menus/FamilyMenu.tscn")





func _on_celebration_button_pressed():
	#remember to update celebration label
	GameData.celebrationCost *= 10
	GameData.celebrationTurnCooldown = 5
	rebellionPoints *= 0.5
	$CelebrationButton.disabled = true
	
