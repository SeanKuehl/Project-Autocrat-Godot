extends Control
const help = preload("res://Game Data Scripts/HelperFunctions.gd")




func _init():
	
	var start = help.new()
	var selections = start.LoadSelectionsFromFile()
	var rights = start.LoadRightsFromFile()
	
	GameData.selections = selections
	GameData.rights = rights
	
	
	GameData.LoadHowToPlayFromFile()
	
	

	
	
	


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_how_to_play_button_pressed():
	get_tree().change_scene_to_file("res://Menus/HowToPlayMenu.tscn")
