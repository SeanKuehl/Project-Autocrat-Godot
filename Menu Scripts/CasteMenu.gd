extends Control
const Caste = preload("res://Game Data Scripts/Caste.gd")
const selectionMenuScene = preload("res://Menus/SelectionMenu.tscn")
const rightMenuScene = preload("res://Menus/RightMenu.tscn")


var menuSelections = []
var selectionsSet = false
var menuRights = []
var rightsSet = false
var menuCaste = []

var thisCasteIsRulingClass = false

var selectionMenu = ""
var rightMenu = ""


func _ready():
	
	
	if typeof(GameData.editCaste) == TYPE_OBJECT:
		EditCaste(GameData.editCaste)
		GameData.editCaste = 0
	else:
		CreateCaste()
	
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
	
	$RulingClassCheck.hide()
	$LowerClassCheck.hide()
	
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
	
	$RulingClassCheck.show()
	$LowerClassCheck.show()
	

func CreateCaste():
	#create new caste object, selections and rights
	menuCaste = Caste.new()
	menuCaste.GenerateCasteID()
	
	menuSelections = GameData.LoadSelectionsFromFile()
	menuRights = GameData.LoadRightsFromFile()
	selectionsSet = false
	rightsSet = false
	
	
func EditCaste(passedCaste):
	#show existing caste values on screen
	menuCaste = passedCaste
	menuSelections = menuCaste.GetSelections()
	menuRights = menuCaste.GetRights()
	thisCasteIsRulingClass = menuCaste.GetRulingClass()
	
	if thisCasteIsRulingClass:
		$RulingClassCheck.button_pressed = true
	else:
		$LowerClassCheck.button_pressed = true
		
	$TitleInput.text = menuCaste.GetTitle()
	$DescriptionInput.text = menuCaste.GetDescription()
	
	
	selectionsSet = true
	rightsSet = true
	
	
func UpdateCaste():
	if ValidTitle() == true and validSelectionAndRights() == true:
		menuCaste.SetTitle($TitleInput.text)
		menuCaste.SetDescription($DescriptionInput.text)
		menuCaste.SetSelections(menuSelections)
		menuCaste.SetRights(menuRights)
		menuCaste.SetRulingClass(thisCasteIsRulingClass)
	
	
	
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
	
	if selectionsSet:
		selectionMenu.EditExisting(menuSelections)
	else:
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
	
	rightMenu.ShowMe()
	
	if rightsSet:
		rightMenu.EditExisting(menuRights)
	else:
		rightMenu.Init()
	
	
func RightMenuDone(newRights):
	rightMenu.HideMe()
	ShowMe()
	menuRights = newRights
	rightsSet = true
	remove_child(rightMenu)


func _on_cancel_button_pressed():
	HideMe()
	get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")
	


func _on_create_button_pressed():
	#check for other castes with same ID, if none just add to list
	UpdateCaste()
	var casteExists = false
	
	if len(GameData.castes) <= 0 and ValidTitle() == true and validSelectionAndRights() == true:
		var newCastes = []
		newCastes.append(menuCaste)
		GameData.castes = newCastes
		HideMe()
		get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")
		
	elif ValidTitle() == true and validSelectionAndRights() == true:
		
		for i in range(len(GameData.castes)):
			if menuCaste.GetCasteID() == GameData.castes[i].GetCasteID():
				GameData.castes[i] = menuCaste
				casteExists = true
				
		if casteExists == false:
		
			GameData.castes.append(menuCaste)
			
		HideMe()
		get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")
	
	else:
		pass
	
	#get_tree().get_current_scene().ready
	
			
	


func _on_ruling_class_check_pressed():
	$LowerClassCheck.button_pressed = false	#you can be either ruling or lower class, not both
	thisCasteIsRulingClass = true

func _on_lower_class_check_pressed():
	$RulingClassCheck.button_pressed = false
	thisCasteIsRulingClass = false
