extends Node

var rightName = ""
var rightOptions = []
var rightEffects = []
var selectedIndex = -1  


func SetName(newName):
	rightName = newName
	
func GetName():
	return rightName
	

func SetOptions(newOptions):
	rightOptions = newOptions

func GetOptions():
	return rightOptions
	

func SetEffects(newEffects):
	rightEffects = newEffects
	
func GetEffects():
	return rightEffects
	
func SetIndex(newIndex):
	selectedIndex = newIndex
	
func GetIndex():
	return selectedIndex
