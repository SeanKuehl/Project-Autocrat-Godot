extends Control
const casteClass = preload("res://Game Data Scripts/Caste.gd")
const selectionMenuScene = preload("res://Menus/SelectionMenu.tscn")
const rightMenuScene = preload("res://Menus/RightMenu.tscn")


var menuSelections = []
var selectionsSet = false
var menuRights = []
var rightsSet = false
var menuCaste = []

var selectionMenu = ""
var rightMenu = ""



	
func HideMe():
	$Panel.mouse_filter = MOUSE_FILTER_IGNORE
	$Panel.hide()
	
	$TitleText.hide()
	$TitleInput.hide()
	
	$DescriptionText.hide()
	$DescriptionInput.hide()
	
	$SelectionButton.hide()
	$RightButton.hide()
	$CreateButton.hide()
	$CancelButton.hide()
	
func ShowMe():
	$Panel.mouse_filter = MOUSE_FILTER_STOP
	$Panel.show()
	
	$TitleText.show()
	$TitleInput.show()
	
	$DescriptionText.show()
	$DescriptionInput.show()
	
	$SelectionButton.show()
	$RightButton.show()
	$CreateButton.show()
	$CancelButton.show()
	

func CreateCaste():
	#create new caste object, selections and rights
	menuCaste = casteClass.new()
	menuCaste.GenerateCasteID()
	menuSelections = GameData.selections
	menuRights = GameData.Rights
	selectionsSet = false
	rightsSet = false
	
	
func EditCaste(passedCaste):
	#show existing caste values on screen
	menuCaste = passedCaste
	menuSelections = menuCaste.GetSelections()
	menuRights = menuCaste.GetRights()
	selectionsSet = true
	rightsSet = true
	
	
func UpdateCaste():
	if ValidTitle() == true and validSelectionAndRights() == true:
		menuCaste.SetTitle($TitleInput.text)
		menuCaste.SetDescription($DescriptionInput.text)
		menuCaste.SetSelections(menuSelections)
		menuCaste.SetRights(menuRights)
	
	
	
func ValidTitle():
	var maxLength = 30 
	var minLength = 1
	var titleValid = false
	
	if $TitleInput.text == "" or $TitleInput.text == " ":
		#it's empty, invalid
		titleValid = false
	
	elif len($TitleInput.text) >= minLength and len($TitleInput.text) <= maxLength:
		titleValid = true
	else:
		titleValid = false
		
	return titleValid
	
#description is optional

func validSelectionAndRights():
	if selectionsSet == false or rightsSet == false:
		return false
	else:
		return true
	
	
	
	
	
	


func _on_selection_button_pressed():
	selectionMenu = selectionMenuScene.instantiate()
	selectionMenu.SelectionDone.connect(SelectionMenuDone)
	
	add_child(selectionMenu)
	HideMe()
	selectionMenu.ShowMe()
	selectionMenu.Init()
	
	

func SelectionMenuDone(newSelections):
	selectionMenu.HideMe()
	ShowMe()
	menuSelections = newSelections
	selectionsSet = true
	remove_child(selectionMenu)

func _on_right_button_pressed():
	rightMenu = rightMenuScene.instantiate()
	
	rightMenu.RightDone.connect(RightMenuDone)
	
	add_child(rightMenu)
	HideMe()
	rightMenu.Init()
	rightMenu.ShowMe()
	
	
func RightMenuDone(newRights):
	rightMenu.HideMe()
	ShowMe()
	menuRights = newRights
	rightsSet = true
	remove_child(rightMenu)


func _on_cancel_button_pressed():
	HideMe()


func _on_create_button_pressed():
	#check for other castes with same ID, if none just add to list
	var casteUpdated = false
	
	for i in range(len(GameData.castes)):
		if menuCaste.GetCasteID() == GameData.castes[i].GetCasteID():
			GameData.casteList[i] = menuCaste
			casteUpdated = true
		
	if casteUpdated == false:
		GameData.castes.append(menuCaste)
		
	HideMe()
			
	
