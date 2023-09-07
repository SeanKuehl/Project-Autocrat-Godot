extends Control

var selections = []
var selectionsListIndex = 0


func _ready():
	selections = GameData.selections
	SetNavigationText()
	SetSelection()
	
	
func SetNavigationText():
	$ProgressLabel.text = str(selectionsListIndex +1) + "/" + str(len(selections))
	
func SetSelectionTitle():
	var title = selections[selectionsListIndex].GetName()
	$SelectionTitle.text = title
	
func UpdateSelectionChoices():
	var allChoices = [$Option1.button_pressed, $Option2.button_pressed, $Option3.button_pressed, $Option4.button_pressed, $Option5.button_pressed,
	$Option6.button_pressed, $Option7.button_pressed, $Option8.button_pressed]
	var numberOfSelectionChoices = len(selections[selectionsListIndex].GetChoices())
	
	var newChoices = []
	for x in range(numberOfSelectionChoices):
		if allChoices[x] == true:
			newChoices.append(1)
		else:
			newChoices.append(0)
			
	selections[selectionsListIndex].SetChoices(newChoices)

func SetSelection():
	SetSelectionTitle()
	SetSelectionOptions()
	SetSelectionChoices()

func SetSelectionChoices():
	var selectionChoices = selections[selectionsListIndex].GetChoices()
	
	if len(selectionChoices) == 2:
		$Option1.button_pressed = selectionChoices[0]
		$Option2.button_pressed = selectionChoices[1]
		
	elif len(selectionChoices) == 3:
		$Option1.button_pressed = selectionChoices[0]
		$Option2.button_pressed = selectionChoices[1]
		$Option3.button_pressed = selectionChoices[2]
		
	elif len(selectionChoices) == 4:
		$Option1.button_pressed = selectionChoices[0]
		$Option2.button_pressed = selectionChoices[1]
		$Option3.button_pressed = selectionChoices[2]
		$Option4.button_pressed = selectionChoices[3]
		
	elif len(selectionChoices) == 5:
		$Option1.button_pressed = selectionChoices[0]
		$Option2.button_pressed = selectionChoices[1]
		$Option3.button_pressed = selectionChoices[2]
		$Option4.button_pressed = selectionChoices[3]
		$Option5.button_pressed = selectionChoices[4]
		
	elif len(selectionChoices) == 6:
		$Option1.button_pressed = selectionChoices[0]
		$Option2.button_pressed = selectionChoices[1]
		$Option3.button_pressed = selectionChoices[2]
		$Option4.button_pressed = selectionChoices[3]
		$Option5.button_pressed = selectionChoices[4]
		$Option6.button_pressed = selectionChoices[5]
		
	elif len(selectionChoices) == 7:
		$Option1.button_pressed = selectionChoices[0]
		$Option2.button_pressed = selectionChoices[1]
		$Option3.button_pressed = selectionChoices[2]
		$Option4.button_pressed = selectionChoices[3]
		$Option5.button_pressed = selectionChoices[4]
		$Option6.button_pressed = selectionChoices[5]
		$Option7.button_pressed = selectionChoices[6]
		
	elif len(selectionChoices) == 8:
		$Option1.button_pressed = selectionChoices[0]
		$Option2.button_pressed = selectionChoices[1]
		$Option3.button_pressed = selectionChoices[2]
		$Option4.button_pressed = selectionChoices[3]
		$Option5.button_pressed = selectionChoices[4]
		$Option6.button_pressed = selectionChoices[5]
		$Option7.button_pressed = selectionChoices[6]
		$Option8.button_pressed = selectionChoices[7]
	
func SetSelectionOptions():
	var currentSelection = selections[selectionsListIndex]
	var numberOfOptions = len(currentSelection.GetOptions())
	var options = currentSelection.GetOptions()
	
	HideAllOptions()
	
	if numberOfOptions == 2:
		$Option1.button_pressed = false
		$Option1.text = options[0]
		$Option1.show()
		
		$Option2.button_pressed = false
		$Option2.text = options[1]
		$Option2.show()
		
	elif numberOfOptions == 3:
		$Option1.button_pressed = false
		$Option1.text = options[0]
		$Option1.show()
		
		$Option2.button_pressed = false
		$Option2.text = options[1]
		$Option2.show()
		
		$Option3.button_pressed = false
		$Option3.text = options[2]
		$Option3.show()
	
	elif numberOfOptions == 4:
		$Option1.button_pressed = false
		$Option1.text = options[0]
		$Option1.show()
		
		$Option2.button_pressed = false
		$Option2.text = options[1]
		$Option2.show()
		
		$Option3.button_pressed = false
		$Option3.text = options[2]
		$Option3.show()
		
		$Option4.button_pressed = false
		$Option4.text = options[3]
		$Option4.show()
		
	elif numberOfOptions == 5:
		$Option1.button_pressed = false
		$Option1.text = options[0]
		$Option1.show()
		
		$Option2.button_pressed = false
		$Option2.text = options[1]
		$Option2.show()
		
		$Option3.button_pressed = false
		$Option3.text = options[2]
		$Option3.show()
		
		$Option4.button_pressed = false
		$Option4.text = options[3]
		$Option4.show()
		
		$Option5.button_pressed = false
		$Option5.text = options[4]
		$Option5.show()
		
	elif numberOfOptions == 6:
		$Option1.button_pressed = false
		$Option1.text = options[0]
		$Option1.show()
		
		$Option2.button_pressed = false
		$Option2.text = options[1]
		$Option2.show()
		
		$Option3.button_pressed = false
		$Option3.text = options[2]
		$Option3.show()
		
		$Option4.button_pressed = false
		$Option4.text = options[3]
		$Option4.show()
		
		$Option5.button_pressed = false
		$Option5.text = options[4]
		$Option5.show()
		
		$Option6.button_pressed = false
		$Option6.text = options[5]
		$Option6.show()
		
	elif numberOfOptions == 7:
		$Option1.button_pressed = false
		$Option1.text = options[0]
		$Option1.show()
		
		$Option2.button_pressed = false
		$Option2.text = options[1]
		$Option2.show()
		
		$Option3.button_pressed = false
		$Option3.text = options[2]
		$Option3.show()
		
		$Option4.button_pressed = false
		$Option4.text = options[3]
		$Option4.show()
		
		$Option5.button_pressed = false
		$Option5.text = options[4]
		$Option5.show()
		
		$Option6.button_pressed = false
		$Option6.text = options[5]
		$Option6.show()
		
		$Option7.button_pressed = false
		$Option7.text = options[6]
		$Option7.show()
		
	elif numberOfOptions == 8:
		$Option1.button_pressed = false
		$Option1.text = options[0]
		$Option1.show()
		
		$Option2.button_pressed = false
		$Option2.text = options[1]
		$Option2.show()
		
		$Option3.button_pressed = false
		$Option3.text = options[2]
		$Option3.show()
		
		$Option4.button_pressed = false
		$Option4.text = options[3]
		$Option4.show()
		
		$Option5.button_pressed = false
		$Option5.text = options[4]
		$Option5.show()
		
		$Option6.button_pressed = false
		$Option6.text = options[5]
		$Option6.show()
		
		$Option7.button_pressed = false
		$Option7.text = options[6]
		$Option7.show()
		
		$Option8.button_pressed = false
		$Option8.text = options[7]
		$Option8.show()
	
func HideAllOptions():
	$Option1.hide()
	$Option2.hide()
	$Option3.hide()
	$Option4.hide()
	$Option5.hide()
	$Option6.hide()
	$Option7.hide()
	$Option8.hide()
		
	


func _on_last_pressed():
	var min = 0 
	
	
	
	if selectionsListIndex > min:
		UpdateSelectionChoices()
		selectionsListIndex -= 1
		SetNavigationText()
		SetSelection()

func _on_next_pressed():
	var max = len(selections)-1
	
	if selectionsListIndex < max:
		UpdateSelectionChoices()
		selectionsListIndex += 1
		SetNavigationText()
		SetSelection()
