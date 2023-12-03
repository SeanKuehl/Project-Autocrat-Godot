extends Control

const familyMemberEvent = preload("res://GameObjects/FamilyMemberEvent.tscn")

var xStart = 0
var xOffset = 275

var yStart = 0

var yOffset = 200

var totalEvents = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	PopulateEvents(GameData.familyEvents)
	GameData.familyEvents = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func PopulateEvents(events):
	var total = 0
	var row = 0
	var column = 0
	
	
	for event in events:
		row = total
		
		
		
		totalEvents += 1
		var newFamilyEvent = familyMemberEvent.instantiate()
		newFamilyEvent.global_position = Vector2(xStart+(xOffset*row),yStart+(yOffset*column))
		#GameData.turnAndPoints = [turnNumber, rebellionPoints, securityPoints, economyPoints]
		newFamilyEvent.FillEvent(event)
		#connect signal
		newFamilyEvent.Placate.connect(PlacateSignalSent)
		newFamilyEvent.Deny.connect(DenySignalSent)
		add_child(newFamilyEvent)
		total += 1
		
		if total == 4:
			total = 0
			column += 1


func PlacateSignalSent(appliedMember, eventType, eventCost):
	DetermineMember(appliedMember, 5)
	DetermineEvent(eventType, eventCost)
	totalEvents -= 1
	
	
	

func DenySignalSent(appliedMember, eventApproval):
	DetermineMember(appliedMember, eventApproval)
	totalEvents -= 1
	
	
	
	
func DetermineMember(member, approval):
	#spouse, first child, second child ...
	if member == "spouse":
		GameData.familyMemberApprovals[0] += approval
		
	elif member == "first child":
		GameData.familyMemberApprovals[1] += approval
		
	elif member == "second child":
		GameData.familyMemberApprovals[2] += approval
		
	elif member == "third child":
		GameData.familyMemberApprovals[3] += approval
		
	elif member == "fourth child":
		GameData.familyMemberApprovals[4] += approval
		
func DetermineEvent(event, cost):
	#pampered(econ), promoted(rebellion), protected(security)
	##GameData.turnAndPoints = [turnNumber, rebellionPoints, securityPoints, economyPoints]
	
	if event == 1:
		#pampered, economy points
		GameData.turnAndPoints[3] += cost
		
	elif event == 2:
		#promoted, rebellion points
		GameData.turnAndPoints[1] += cost
		
	elif event == 3:
		GameData.turnAndPoints[2] += cost


func _on_continue_button_pressed():
	if totalEvents == 0:
		get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")
