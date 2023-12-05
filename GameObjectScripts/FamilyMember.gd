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
	memberName = "Ruler"
	gender = "Male"
	
	var traitOne = ["Iron Fist", "Kindness is weakness"]
	var traitTwo = ["Glorious", "My glory shines upon all"]
	var traitThree = ["Petty", "Oh you like THAT flavor?"]
	
	traits = [traitOne, traitTwo, traitThree]
	
	icon = ResourceLoader.load("res://assets/Images/GameObjects/king.png")
	
	$TraitOne.texture = load("res://assets/Images/GameObjects/ironfist.png")
	$TraitTwo.texture = load("res://assets/Images/GameObjects/glory.png")
	$TraitThree.texture = load("res://assets/Images/GameObjects/petty.png")
	
	
func GetSpouseTraits():
	#var spouseOnlyTraits = GameData.LoadSpouseTraitsFromFile()
	#var memberTraits = GameData.LoadMemberTraitsFromFile()
	
	var traitOne = ["Spouse", "Concubine? Consort? You know, that thing"]
	var traitTwo = GetAmbition()
	var traitThree = GetCorruption()
	
	traits = [traitOne, traitTwo, traitThree]
	
	icon = ResourceLoader.load("res://assets/Images/GameObjects/queen.png")
	
	$TraitOne.texture = load("res://assets/Images/GameObjects/spouse.png")
	
	
func GetMemberTraits():
	#var memberTraits = GameData.LoadMemberTraitsFromFile()
	
	var traitOne = ["Child", "Ungrateful swine"]
	var traitTwo = GetAmbition()
	var traitThree = GetCorruption()
	
	traits = [traitOne, traitTwo, traitThree]
	
	$TraitOne.texture = load("res://assets/Images/GameObjects/child.png")
	
	

	
func GetAmbition():
	var chance = rng.randi_range(1,3)
	#chances are 1/16, 1/8 and 1/4
	
	if chance == 1:
		#low chance of random event
		ambition = 16
		$TraitTwo.texture = load("res://assets/Images/GameObjects/lowambition.png")
		return ["Low Ambition", "I'm grateful for my place"]
	elif chance == 2:
		ambition = 8
		$TraitTwo.texture = load("res://assets/Images/GameObjects/averageambition.png")
		return ["Average Ambition", "Things could be better"]
	elif chance == 3:
		ambition = 4
		$TraitTwo.texture = load("res://assets/Images/GameObjects/highambition.png")
		return ["High Ambition", "The world is MINE"]
		

func GetCorruption():
	var chance = rng.randi_range(1,3)
	#mults are 1, 2 and 4
	
	if chance == 1:
		#low corruption
		corruptionMultiplier = 1
		$TraitThree.texture = load("res://assets/Images/GameObjects/lowcorruption.png")
		return ["Low Corruption", "Keep the change"]
	elif chance == 2:
		corruptionMultiplier = 2
		$TraitThree.texture = load("res://assets/Images/GameObjects/averagecorruption.png")
		return ["Average Corruption", "I earned it"]
	elif chance == 3:
		corruptionMultiplier = 3
		$TraitThree.texture = load("res://assets/Images/GameObjects/highcorruption.png")
		return ["High Corruption", "What do you mean YOUR property?"]

func GenerateSpouse():
	gender = "Female"
	
	
	var possibleNames = GameData.LoadGirlsNamesFromFile()
	var randNum = rng.randi_range(0,len(possibleNames)-1)
	memberName = possibleNames[randNum]
	
	GetSpouseTraits()
	GameData.spouseChances = [ambition, corruptionMultiplier]
	GameData.spouseInfo = [memberName, gender]
	
func GetNameAndGender():
	return [memberName, gender]
	
	
func RestoreFamilyMember(myName, myGender, myAmbition, myCorruption, memberType):
	memberName = myName
	gender = myGender
	ambition = myAmbition
	corruptionMultiplier = myCorruption
	
	traits = [[],[],[]]
	
	if corruptionMultiplier == 1:
		#low corruption
		
		$TraitThree.texture = load("res://assets/Images/GameObjects/lowcorruption.png")
		traits[2] = ["Low Corruption", "Keep the change"]
	elif corruptionMultiplier == 2:
		
		$TraitThree.texture = load("res://assets/Images/GameObjects/averagecorruption.png")
		traits[2] = ["Average Corruption", "I earned it"]
	elif corruptionMultiplier == 3:
		
		$TraitThree.texture = load("res://assets/Images/GameObjects/highcorruption.png")
		traits[2] = ["High Corruption", "What do you mean YOUR property?"]
		
		
	if ambition == 16:
		#low chance of random event
		
		$TraitTwo.texture = load("res://assets/Images/GameObjects/lowambition.png")
		traits[1] = ["Low Ambition", "I'm grateful for my place"]
	elif ambition == 8:
		
		$TraitTwo.texture = load("res://assets/Images/GameObjects/averageambition.png")
		traits[1] = ["Average Ambition", "Things could be better"]
	elif ambition == 4:
		
		$TraitTwo.texture = load("res://assets/Images/GameObjects/highambition.png")
		traits[1] = ["High Ambition", "The world is MINE"]
		
		
	if memberType == "spouse":
		icon = ResourceLoader.load("res://assets/Images/GameObjects/queen.png")
		traits[0] = ["Spouse", "Concubine? Consort? You know, that thing"]
		$TraitOne.texture = load("res://assets/Images/GameObjects/spouse.png")
	elif memberType == "child":
		$TraitOne.texture = load("res://assets/Images/GameObjects/child.png")
		traits[0] = ["Child", "Ungrateful swine"]
		
		if gender == "Male":
			icon = ResourceLoader.load("res://assets/Images/GameObjects/prince.png")
		elif gender == "Female":
			icon = ResourceLoader.load("res://assets/Images/GameObjects/princess.png")
	
	
func GenerateFamilyMember():
	var randNum = rng.randi_range(1,2)
	
	if randNum == 1:
		gender = "Male"
		var possibleNames = GameData.LoadBoysNamesFromFile()
		randNum = rng.randi_range(0,len(possibleNames)-1)
		memberName = possibleNames[randNum]
		icon = ResourceLoader.load("res://assets/Images/GameObjects/prince.png")
		
		
	elif randNum == 2:
		gender = "Female"
		var possibleNames = GameData.LoadGirlsNamesFromFile()
		randNum = rng.randi_range(0,len(possibleNames)-1)
		memberName = possibleNames[randNum]
		icon = ResourceLoader.load("res://assets/Images/GameObjects/princess.png")
		
	GetMemberTraits()
	
func GetAmbitionAndCorruption():
	return [ambition, corruptionMultiplier]
