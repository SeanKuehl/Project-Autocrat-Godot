extends Control

var rights = []
var rightsIndex = 0
var selectedButtonIndex = -1

signal RightDone(rights)

func Init():
	rights = GameData.rights
	SetNavigationText()
	SetRight()
	
func SetRight():
	SetTitle()
	ClearOptionsAndEffects()
	SetRightOptionsAndEffects()
	

func UpdateRight():
	if selectedButtonIndex > 0:
		rights[rightsIndex].SetIndex(selectedButtonIndex-1)
	else:
		rights[rightsIndex].SetIndex(selectedButtonIndex)
	
	selectedButtonIndex = -1
	
	
func SetNavigationText():
	$NavigationText.text = str(rightsIndex+1) + "/" + str(len(rights))
	
func SetTitle():
	var title = rights[rightsIndex].GetName()
	$Title.text = title
	
func SetRightOptionsAndEffects():
	var thisRight = rights[rightsIndex]
	var options = thisRight.GetOptions()
	var effects = thisRight.GetEffects()
	var thisIndex = thisRight.GetIndex()
	var numberOfOptions = len(thisRight.GetOptions())
	var buttons = [$Option1, $Option2, $Option3, $Option4]
	#usually 3, max 4
	
	
	
	if numberOfOptions == 3:
		
		
		$Option1.text = options[0] + "(" + effects[0] + ")"
		$Option1.button_pressed = false
		$Option1.show()
		
		$Option2.text = options[1] + "(" + effects[1] + ")"
		$Option2.button_pressed = false
		$Option2.show()
		
		$Option3.text = options[2] + "(" + effects[2] + ")"
		$Option3.button_pressed = false
		$Option3.show()
		
	elif numberOfOptions == 4:
		$Option1.text = options[0] + "(" + effects[0] + ")"
		$Option1.button_pressed = false
		$Option1.show()
		
		$Option2.text = options[1] + "(" + effects[1] + ")"
		$Option2.button_pressed = false
		$Option2.show()
		
		$Option3.text = options[2] + "(" + effects[2] + ")"
		$Option3.button_pressed = false
		$Option3.show()
		
		$Option4.text = options[3] + "(" + effects[3] + ")"
		$Option4.button_pressed = false
		$Option4.show()
		
	if thisIndex >= 0:
			buttons[thisIndex].button_pressed = true
		
func ClearOptionsAndEffects():
	$Option1.text = ""
	$Option1.button_pressed = false
	$Option1.hide()
	
	$Option2.text = ""
	$Option2.button_pressed = false
	$Option2.hide()
	
	$Option3.text = ""
	$Option3.button_pressed = false
	$Option3.hide()
	
	$Option4.text = ""
	$Option4.button_pressed = false
	$Option4.hide()
	
	
func HideMe():
	
	
	$Panel.mouse_filter = MOUSE_FILTER_IGNORE
	$Panel.hide()
	$Title.hide()
	$Previous.hide()
	$Next.hide()
	$NavigationText.hide()
	
	$Option1.hide()
	$Option2.hide()
	$Option3.hide()
	$Option4.hide()
	
func ShowMe():
	$Panel.mouse_filter = MOUSE_FILTER_STOP
	$Panel.show()
	
	$Title.show()
	$Option1.show()
	$Option2.show()
	$Option3.show()
	$Option4.show()
	
	$Previous.show()
	$Next.show()
	$NavigationText.show()


func _on_previous_pressed():
	var min = 0 
	
	if rightsIndex > min:
		UpdateRight()
		rightsIndex -= 1
		SetRight()
		SetNavigationText()


func _on_next_pressed():
	var max = len(rights)-1
	
	if rightsIndex == max:
		#user is done
		UpdateRight()
		RightDone.emit(rights)
		HideMe()
	
	if rightsIndex < max:
		UpdateRight()
		rightsIndex += 1
		SetRight()
		SetNavigationText()


func _on_option_1_pressed():
	if $Option1.button_pressed == true:
		#disable the others, set pressed index to this button
		selectedButtonIndex = 1
		$Option2.button_pressed = false
		$Option3.button_pressed = false
		$Option4.button_pressed = false


func _on_option_2_pressed():
	if $Option2.button_pressed == true:
		#disable the others, set pressed index to this button
		selectedButtonIndex = 2
		$Option1.button_pressed = false
		$Option3.button_pressed = false
		$Option4.button_pressed = false


func _on_option_3_pressed():
	if $Option3.button_pressed == true:
		#disable the others, set pressed index to this button
		selectedButtonIndex = 3
		$Option2.button_pressed = false
		$Option1.button_pressed = false
		$Option4.button_pressed = false


func _on_option_4_pressed():
	if $Option4.button_pressed == true:
		#disable the others, set pressed index to this button
		selectedButtonIndex = 4
		$Option2.button_pressed = false
		$Option3.button_pressed = false
		$Option1.button_pressed = false
