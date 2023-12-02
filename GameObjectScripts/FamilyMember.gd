extends Button

var memberName = ""
var gender = ""

var traits = []

var ambition = 0
var corruptionMultiplier = 0

var rng = RandomNumberGenerator.new()

signal ShowMember(myName, myGender, myTraits)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	#send signal to display traits, name etc
	emit_signal("ShowMember", memberName, gender, traits)
	

func GetRulerTraits():
	var traitOne = ["Iron Fist", "Kindness is weakness"]
	var traitTwo = ["Glorious", "My glory shines upon all"]
	var traitThree = ["Petty", "Oh you like THAT flavor?"]
	
	traits = [traitOne, traitTwo, traitThree]
	
	
func GetSpouseTraits():
	var spouseOnlyTraits = GameData.LoadSpouseTraitsFromFile()
	var memberTraits = GameData.LoadMemberTraitsFromFile()
	
	var traitOne = ["Spouse", "Concubine? Consort? You know, that thing"]
	var traitTwo = GetAmbition()
	var traitThree = GetCorruption()
	
	traits = [traitOne, traitTwo, traitThree]
	
	
func GetMemberTraits():
	var memberTraits = GameData.LoadMemberTraitsFromFile()
	
	var traitOne = ["Child", "Ungrateful swine"]
	var traitTwo = GetAmbition()
	var traitThree = GetCorruption()
	
	traits = [traitOne, traitTwo, traitThree]

	
func GetAmbition():
	var chance = rng.randi_range(1,3)
	#chances are 1/16, 1/8 and 1/4
	
	if chance == 1:
		#low chance of random event
		ambition = 16
		return ["Low Ambition", "I'm grateful for my place"]
	elif chance == 2:
		ambition = 8
		return ["Average Ambition", "Things could be better"]
	elif chance == 3:
		ambition = 4
		return ["High Ambition", "The world is MINE"]
		

func GetCorruption():
	var chance = rng.randi_range(1,3)
	#mults are 1, 2 and 4
	
	if chance == 1:
		#low corruption
		corruptionMultiplier = 1
		return ["Low Corruption", "Keep the change"]
	elif chance == 2:
		corruptionMultiplier = 2
		return ["Average Corruption", "I earned it"]
	elif chance == 3:
		corruptionMultiplier = 3
		return ["High Corruption", "What do you mean YOUR property?"]

func GenerateSpouse():
	gender = "Female"
	
	GetSpouseTraits()
	
	
func GenerateFamilyMember():
	var randNum = rng.randi_range(1,2)
	
	if randNum == 1:
		gender = "Male"
		var possibleNames = GameData.LoadBoysNamesFromFile()
		randNum = rng.randi_range(0,len(possibleNames)-1)
		memberName = possibleNames[randNum]
		
		
	elif randNum == 2:
		gender = "Female"
		var possibleNames = GameData.LoadGirlsNamesFromFile()
		randNum = rng.randi_range(0,len(possibleNames)-1)
		memberName = possibleNames[randNum]
		
	GetMemberTraits()
