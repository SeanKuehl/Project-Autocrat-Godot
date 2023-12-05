extends Control

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ruler.GetRulerTraits()
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
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
		
	elif GameData.secondChildChances == [0,0] and GameData.spouseChances != [0,0]:
		#there is currently no second child
		if chance == 1:
			$ChildTwo.GenerateFamilyMember()
			GameData.secondChildChances = $ChildTwo.GetAmbitionAndCorruption()
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
		
	elif GameData.thirdChildChances == [0,0] and GameData.spouseChances != [0,0]:
		#there is currently no third child
		if chance == 1:
			$ChildThree.GenerateFamilyMember()
			GameData.thirdChildChances = $ChildThree.GetAmbitionAndCorruption()
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
		
	elif GameData.fourthChildChances == [0,0] and GameData.spouseChances != [0,0]:
		#there is currently no fourth child
		if chance == 1:
			$ChildFour.GenerateFamilyMember()
			GameData.fourthChildChances = $ChildFour.GetAmbitionAndCorruption()
		else:
			$MemberDisplay.text = "Failed, no dad jokes for you"
			$TryForChildButton.disabled = true
			GameData.childCooldown = 1
