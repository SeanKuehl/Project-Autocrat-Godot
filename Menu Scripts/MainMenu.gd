extends Node
const help = preload("res://Game Data Scripts/HelperFunctions.gd")

func _init():
	var start = help.new()
	var selections = start.LoadSelectionsFromFile()
	var rights = start.LoadRightsFromFile()
	
	for x in rights:
		print(x.GetName())
		print(x.GetOptions())
	
