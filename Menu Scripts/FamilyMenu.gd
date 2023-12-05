extends Control

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
#RestoreFamilyMember(myName, myGender, myAmbition, myCorruption, memberType)
func _ready():
	$Ruler.GetRulerTraits()
	RestoreMembers()
	$Ruler.ShowMember.connect(DisplayMember)
	
	$Spouse.ShowMember.connect(DisplayMember)
	
	$ChildOne.ShowMember.connect(DisplayMember)
	$ChildTwo.ShowMember.connect(DisplayMember)
	$ChildThree.ShowMember.connect(DisplayMember)
	$ChildFour.ShowMember.connect(DisplayMember)
	
	if GameData.marryCooldown > 0:
		GameData.marryCooldown -= 1
		$MarryButton.disabled = false
		
	if GameData.childCooldown > 0:
		GameData.childCooldown -= 1
		$TryForChildButton.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func RestoreMembers():
	
	if GameData.spouseChances != [0,0]:
		$Spouse.RestoreFamilyMember(GameData.spouseInfo[0], GameData.spouseInfo[1], GameData.spouseChances[0], GameData.spouseChances[1], "spouse")

	if GameData.firstChildChances != [0,0]:
		$ChildOne.RestoreFamilyMember(GameData.firstChildInfo[0], GameData.firstChildInfo[1], GameData.firstChildChances[0], GameData.firstChildChances[1], "child")

	if GameData.secondChildChances != [0,0]:
		$ChildTwo.RestoreFamilyMember(GameData.secondChildInfo[0], GameData.secondChildInfo[1], GameData.secondChildChances[0], GameData.secondChildChances[1], "child")

	if GameData.thirdChildChances != [0,0]:
		$ChildThree.RestoreFamilyMember(GameData.thirdChildInfo[0], GameData.thirdChildInfo[1], GameData.thirdChildChances[0], GameData.thirdChildChances[1], "child")

	if GameData.fourthChildChances != [0,0]:
		$ChildFour.RestoreFamilyMember(GameData.fourthChildInfo[0], GameData.fourthChildInfo[1], GameData.fourthChildChances[0], GameData.fourthChildChances[1], "child")


func DisplayMember(memberName, gender, traits):
	if memberName == "" or gender == "":
		$MemberDisplay.text = ""
	else:
	
		var display = "Name: "+memberName+".\nGender: "+gender+"."
		
		for x in traits:
			display += "\n"+x[0]+": "+x[1]+"\n"
			
		$MemberDisplay.text = display
	

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")


func _on_marry_button_pressed():
	var chance = rng.randi_range(1,4)
	
	if GameData.spouseChances == [0,0]:
		#there is currently no spouse,
		if chance == 1:
			$Spouse.GenerateSpouse()
		else:
			$MemberDisplay.text = "Failed, so lonely"
			$MarryButton.disabled = true
			GameData.marryCooldown = 1


func _on_try_for_child_button_pressed():
	var chance = rng.randi_range(1,4)
	
	
	
	
	if GameData.firstChildChances == [0,0] and GameData.spouseChances != [0,0]:
		#there is currently no first child
		if chance == 1:
			$ChildOne.GenerateFamilyMember()
			GameData.firstChildChances = $ChildOne.GetAmbitionAndCorruption()
			GameData.firstChildInfo = $ChildOne.GetNameAndGender()
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
		
	elif GameData.secondChildChances == [0,0] and GameData.spouseChances != [0,0]:
		#there is currently no second child
		if chance == 1:
			$ChildTwo.GenerateFamilyMember()
			GameData.secondChildChances = $ChildTwo.GetAmbitionAndCorruption()
			GameData.secondChildInfo = $ChildTwo.GetNameAndGender()
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
		
	elif GameData.thirdChildChances == [0,0] and GameData.spouseChances != [0,0]:
		#there is currently no third child
		if chance == 1:
			$ChildThree.GenerateFamilyMember()
			GameData.thirdChildChances = $ChildThree.GetAmbitionAndCorruption()
			GameData.thirdChildInfo = $ChildThree.GetNameAndGender()
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
		
	elif GameData.fourthChildChances == [0,0] and GameData.spouseChances != [0,0]:
		#there is currently no fourth child
		if chance == 1:
			$ChildFour.GenerateFamilyMember()
			GameData.fourthChildChances = $ChildFour.GetAmbitionAndCorruption()
			GameData.fourthChildInfo = $ChildFour.GetNameAndGender()
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
