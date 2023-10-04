extends Button

var memberName = ""
var gender = ""

var traits = []

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
