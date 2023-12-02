extends Control

const familyMemberEvent = preload("res://GameObjects/FamilyMemberEvent.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func PopulateEvents(events):
	
	for event in events:
		var newFamilyEvent = familyMemberEvent.instantiate()
		newFamilyEvent.global_position = Vector2(0,0)
	
		newFamilyEvent.FillEvent(event)
		add_child(newFamilyEvent)
