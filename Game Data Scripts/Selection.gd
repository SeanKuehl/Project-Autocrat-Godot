extends Node

var selectionName = ""
var selectionOptions = []
var selectionChoices = []


func SetName(newName):
	selectionName = newName
	
func GetName():
	return selectionName
	
func SetOptions(newOptions):
	selectionOptions = newOptions
	
	for item in selectionOptions:
		selectionChoices.append(0)
		
func GetOptions():
	return selectionOptions
	
func SetChoices(newChoices):
	selectionChoices = newChoices
	
func GetChoices():
	return selectionChoices
