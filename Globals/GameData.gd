extends Node



var selections = []
var rights = []

var castes = []
var casteIDBase = 1

var editCaste = 0

var turnsAtWar = 0
var warStatus = "No War"
var warDifficulty = "easy"

var familyEvents = []

var spouseChances = [0,0]
var firstChildChances = [0,0]
var secondChildChances = [0,0]
var thirdChildChances = [0,0]
var fourthChildChances = [0,0]

var familyMemberApprovals = [0,0,0,0,0]

var turnAndPoints = [0,0,0,0]

var celebrationCost = 1000
var celebrationTurnCooldown = 0

var marryCooldown = 1
var childCooldown = 1

const selectionBase = preload("res://Game Data Scripts/Selection.gd")
const rightBase = preload("res://Game Data Scripts/Right.gd")

#this file will be used for things like file reading functions, music loading
#functions and the like that are used as the base for other script functions

func GetTurnsAtWar():
	return turnsAtWar

func SetTurnsAtWar(newTurn):
	turnsAtWar = newTurn
	
func GetWarStatus():
	return warStatus
	
func SetWarStatus(newStatus):
	warStatus = newStatus

	


func ReadLinesFromFile(fileName):
	var file = FileAccess.open(fileName, FileAccess.READ)
	var content = file.get_as_text()
	
	#check for empty lines! reading etc the file will add an empty line onto the end of it
	

	file.close()

	return content
	

func LoadSpouseTraitsFromFile():
	var content = ReadLinesFromFile("res://assets/FamilyData/SpouseTriaits.txt")
	var noNew = content.split("\n") #get rid of newlines
	var names = []
	
	return names
	
func LoadMemberTraitsFromFile():
	var content = ReadLinesFromFile("res://assets/FamilyData/MemberTraits.txt")
	var noNew = content.split("\n") #get rid of newlines
	var names = []
	
	return names
	
	
func LoadBoysNamesFromFile():
	var content = ReadLinesFromFile("res://assets/FamilyData/MaleNames.txt")
	var noNew = content.split("\n") #get rid of newlines
	
	
	return noNew
	
func LoadGirlsNamesFromFile():
	var content = ReadLinesFromFile("res://assets/FamilyData/FemaleNames.txt")
	var noNew = content.split("\n") #get rid of newlines
	
	
	return noNew
	
	
func LoadHowToPlayFromFile():
	var content = ReadLinesFromFile("res://assets/HowToPlay/HowToPlay.txt")
	var noNew = content.split("\n") #get rid of newlines
	var howToEntries = []
	var thisString = ""
	
	for x in content:
		if x == "1":
			#start of new entry
			howToEntries.append(thisString)
			thisString = ""
		elif x != "1":
			thisString += x
	
	return howToEntries
	
	
	
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
	
	
func LoadRightsFromFile():
	var content = ReadLinesFromFile("res://assets/Game Data/Rights.txt")
	var noNew = content.split("\n") #get rid of newlines
	var rights = []
	
	for item in noNew:
		var newRight = rightBase.new()
		var nameAndOptions = item
		nameAndOptions = nameAndOptions.split(",")
		newRight.SetName(nameAndOptions[0])
		
		var alteredLastElement = nameAndOptions[-1].strip_escapes() #last option has \r on it for some reason, this gets rid of it
		nameAndOptions.remove_at(len(nameAndOptions)-1)
		nameAndOptions.append(alteredLastElement)
		
		
		nameAndOptions.remove_at(0)
		
		#half of the remaining elements are the text options and the second half
		#are the effects of those options
		
		
		var options = nameAndOptions
		var numberOfOptions = len(options) / 2
		var textOptions = []
		var effects = []
		
		for x in range(len(options)):
			if x < numberOfOptions:
				textOptions.append(options[x])
			else:
				effects.append(options[x])
		
		
		newRight.SetOptions(textOptions)
		newRight.SetEffects(effects)
		rights.append(newRight)
		
	
		
	return rights


