extends Control

const casteDisplayScene = preload("res://GameObjects/CasteDisplay.tscn")

func _ready():
	DisplayCastes()
	
			
func DisplayCastes():
	#display all castes in the list
	
	if len(GameData.castes) <= 0:
		#nothing to show, do nothing
		pass
	else:
		#display castes in CasteDisplay objects
		
		
		for caste in GameData.castes:
			print(caste)
			print("got here")
			print(GameData.castes[0].GetTitle())
			var newCaste = casteDisplayScene.instantiate()
			newCaste.global_position = Vector2(100,100)
			print(caste.GetTitle())
			newCaste.DisplayCaste(caste)
			add_child(newCaste)
			
		

	


func _on_create_caste_button_pressed():
	get_tree().change_scene_to_file("res://Menus/CasteMenu.tscn")
	get_tree().get_current_scene().ready
	
	
