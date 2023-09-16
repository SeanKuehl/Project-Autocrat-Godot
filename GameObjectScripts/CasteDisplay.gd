extends Control

const Caste = preload("res://Game Data Scripts/Caste.gd")



func DisplayCaste(passedCaste: Caste):
	
	
	$CasteTitle.text = passedCaste.GetTitle()
	$CasteDescription.text = passedCaste.GetDescription()
	$Approval.text = str(passedCaste.GetApproval() + passedCaste.GetRelativeApproval())
	$Limitedness.text = str(passedCaste.GetLimitedness())



func _on_edit_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	get_tree().get_current_scene().EditCaste
