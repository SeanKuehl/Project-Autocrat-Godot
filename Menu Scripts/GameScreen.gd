extends Control

const casteDisplayScene = preload("res://GameObjects/CasteDisplay.tscn")

var turnNumber = 1
var rebellionPoints = 0

func _ready():
	GetRelativeApproval()
	DisplayCastes()
	$RebellionPointsLabel.text = "Rebellion Points: " + str(rebellionPoints)
	$TurnCountLabel.text = "Turn: " +str(turnNumber)

			
func DisplayCastes():
	#display all castes in the list
	var casteApprovalIndex = 0
	var casteLocation = 100
	
	if len(GameData.castes) <= 0:
		#nothing to show, do nothing
		pass
	else:
		#display castes in CasteDisplay objects
		
		
		for caste in GameData.castes:
			
			var newCaste = casteDisplayScene.instantiate()
			newCaste.global_position = Vector2(100,casteLocation)
			casteLocation += 100
			newCaste.DisplayCaste(caste)
			add_child(newCaste)
			
		
func GetRelativeApproval():
	var relativeApprovalList = []
	var relativeApproval = 0
	var casteIndex = 0
	
	if len(GameData.castes) > 1:
		#if there is more than one caste, then there is relative approval/
		#relation between them
		#for each caste, get difference in approval * difference in limitedness
		#with each other caste and this is the relative approval
		for thisCaste in GameData.castes:
			for caste in GameData.castes:
				if thisCaste.GetCasteID() == caste.GetCasteID():
					#if they are the same, do nothing
					pass	
				else:
					var differenceInApproval = abs(thisCaste.GetApproval() - caste.GetApproval())
					var differenceInLimitedness = abs(thisCaste.GetLimitedness() - caste.GetLimitedness())
					relativeApproval += differenceInApproval * differenceInLimitedness
					
			GameData.castes[casteIndex].SetRelativeApproval(relativeApproval)
			
			relativeApproval = 0
			casteIndex += 1
			
		
func CalculateRebellionPoints():
	var rebellionPoints = 0
	
	for caste in GameData.castes:
		var weightedPoints = caste.GetApproval() * caste.GetLimitedness()
		if weightedPoints < 0:
			weightedPoints = weightedPoints / 2 #divide by two to make easier for smaller ruling class to succeed
			rebellionPoints += weightedPoints
		else:
			#caste is happy, does not contribute towards rebellion
			pass
			
	return rebellionPoints
		


func _on_create_caste_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	get_tree().get_current_scene().ready
	
	


func _on_end_turn_pressed():
	if len(GameData.castes) > 1:
		#at least 2 castes
		turnNumber += 1
		rebellionPoints += CalculateRebellionPoints()
		$RebellionPointsLabel.text = "Rebellion Points: " + str(rebellionPoints)
		$TurnCountLabel.text = "Turn: " +str(turnNumber)
		
	if rebellionPoints >= 20:
		get_tree().change_scene_to_file("res://Menus/DefeatScreen.tscn")
	elif turnNumber == 20:
		get_tree().change_scene_to_file("res://Menus/VictoryScreen.tscn")
		
		
		
		
