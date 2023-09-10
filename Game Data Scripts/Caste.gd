extends Node

var casteTitle = ""
var casteDescription = ""
var casteSelections = []
var casteRights = []

var casteID = -1

func GenerateCasteID():
	casteID = GameData.casteIDBase
	GameData.casteIDBase += 1
	
func GetCasteID():
	return casteID

func SetTitle(newTitle):
	casteTitle = newTitle
	
func GetTitle():
	return casteTitle
	
func SetDescription(newDesc):
	casteDescription = newDesc
	
func GetDescription():
	return casteDescription
	
func SetSelections(newSelections):
	casteSelections = newSelections
	
func GetSelections():
	return casteSelections
	
func SetRights(newRights):
	casteRights = newRights
	
func GetRights():
	return casteRights
	

