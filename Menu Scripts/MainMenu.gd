extends Node
const help = preload("res://Game Data Scripts/HelperFunctions.gd")

func _init():
	var start = help.new()
	var selections = start.LoadSelectionsFromFile()
	
	for x in selections:
		print(x.GetName())
		print(x.GetOptions())
	
