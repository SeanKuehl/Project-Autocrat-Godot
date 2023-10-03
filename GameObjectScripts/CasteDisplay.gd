extends Control

const Caste = preload("res://Game Data Scripts/Caste.gd")

var thisCaste = []

func DisplayCaste(passedCaste: Caste):
	
	thisCaste = passedCaste
	$CasteTitle.text = passedCaste.GetTitle()
	$CasteDescription.text = passedCaste.GetDescription()
	$Approval.text = "Approval: " +str(passedCaste.GetApproval())
	$Limitedness.text = "Limitedness: " +str(passedCaste.GetLimitedness())



func _on_edit_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	GameData.editCaste = thisCaste
	get_tree().get_current_scene().ready
	
