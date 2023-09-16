extends Control

const casteDisplayScene = preload("res://GameObjects/CasteDisplay.tscn")


func _ready():
	GetRelativeApproval()
	DisplayCastes()
	
			
func DisplayCastes():
	#display all castes in the list
	var casteApprovalIndex = 0
	
	if len(GameData.castes) <= 0:
		#nothing to show, do nothing
		pass
	else:
		#display castes in CasteDisplay objects
		
		
		for caste in GameData.castes:
			
			var newCaste = casteDisplayScene.instantiate()
			newCaste.global_position = Vector2(100,100)
			
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
			
		



func _on_create_caste_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	get_tree().get_current_scene().ready
	
	
