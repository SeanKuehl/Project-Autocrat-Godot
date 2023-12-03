extends Control

#signal ShowMember(myName, myGender, myTraits)
#emit_signal("ShowMember", memberName, gender, traits)

signal Placate(member, type, cost)
signal Deny(member, approval)

var appliedMember = ""
var eventType = ""
var eventCost = 0
var eventApproval = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func FillEvent(event):
	
	$NoticeLabel.text = event[1]
	appliedMember = event[0]
	eventType = event[2]
	eventCost = event[3]
	eventApproval = event[4]


func _on_placate_button_pressed():
	emit_signal("Placate", appliedMember, eventType, eventCost)
	
	queue_free()
	
	


func _on_deny_button_pressed():
	emit_signal("Deny", appliedMember, eventApproval)
	
	queue_free()
	
	
	
	
	
	
