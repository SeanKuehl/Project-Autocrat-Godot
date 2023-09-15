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
	
func GetApproval():
	var totalApproval = 0
	for right in casteRights:
		var effects = right.GetEffects()
		var index = right.GetIndex()
		totalApproval += int(effects[index])
		
	return totalApproval
	
func GetLimitedness():
	var limitednessScore = 0
	var numberOfChoicesMade = 0
	var totalOptions = 0
	
	for selection in casteSelections:
		var choices = selection.GetChoices()
		totalOptions = len(choices)
		for x in choices:
			if x == 1:
				numberOfChoicesMade += 1
				
		if numberOfChoicesMade == 0:
			#they made none, default to all included
			limitednessScore += 1	#same as total options / total options
		else:
			#they made some choices and not others
			limitednessScore += numberOfChoicesMade / totalOptions	#include men but not women? 1/2
			
	return limitednessScore
				
	

