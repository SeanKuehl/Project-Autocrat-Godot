extends Node

const selectionBase = preload("res://Game Data Scripts/Selection.gd")

#this file will be used for things like file reading functions, music loading
#functions and the like that are used as the base for other script functions


func ReadLinesFromFile(fileName):
	var file = FileAccess.open(fileName, FileAccess.READ)
	var content = file.get_as_text()
	
	#check for empty lines! reading etc the file will add an empty line onto the end of it
	

	file.close()

	return content
	
func LoadSelectionsFromFile():
	var content = ReadLinesFromFile("res://assets/Game Data/Selections.txt")
	var noNew = content.split("\n") #get rid of newlines
	var selections = []
	
	for item in noNew:
		var newSelection = selectionBase.new()
		var nameAndOptions = item
		nameAndOptions = nameAndOptions.split(",")
		newSelection.SetName(nameAndOptions[0])
		
		var alteredLastElement = nameAndOptions[-1].strip_escapes() #last option has \r on it for some reason, this gets rid of it
		nameAndOptions.remove_at(len(nameAndOptions)-1)
		nameAndOptions.append(alteredLastElement)
		
		
		nameAndOptions.remove_at(0)
		var options = nameAndOptions
		newSelection.SetOptions(options)
		
		selections.append(newSelection)
		
		
	selections.remove_at(len(selections)-1) #remove empty element at end
		
	return selections
		
		
	
	
