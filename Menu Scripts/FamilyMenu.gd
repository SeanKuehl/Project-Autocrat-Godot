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
