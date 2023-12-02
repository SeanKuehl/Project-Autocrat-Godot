extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Ruler.GetRulerTraits()
	$Ruler.ShowMember.connect(DisplayMember)
	
	$Spouse.ShowMember.connect(DisplayMember)
	
	$ChildOne.ShowMember.connect(DisplayMember)
	$ChildTwo.ShowMember.connect(DisplayMember)
	$ChildThree.ShowMember.connect(DisplayMember)
	$ChildFour.ShowMember.connect(DisplayMember)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func DisplayMember(memberName, gender, traits):
	if memberName == "" or gender == "":
		pass
	else:
	
		var display = "Name: "+memberName+". Gender: "+gender+"."
		
		for x in traits:
			display += "\n"+x
			
		$MemberDisplay.text = display
	

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")


func _on_marry_button_pressed():
	
	if GameData.spouseChances == [0,0]:
		#there is currently no spouse,
		$Spouse.GenerateSpouse()


func _on_try_for_child_button_pressed():
	
	
	if GameData.firstChildChances == [0,0]:
		#there is currently no first child
		$ChildOne.GenerateFamilyMember()
		
	elif GameData.secondChildChances == [0,0]:
		#there is currently no second child
		$ChildTwo.GenerateFamilyMember()
		
	elif GameData.thirdChildChances == [0,0]:
		#there is currently no third child
		$ChildThree.GenerateFamilyMember()
		
	elif GameData.fourthChildChances == [0,0]:
		#there is currently no fourth child
		$ChildFour.GenerateFamilyMember()
