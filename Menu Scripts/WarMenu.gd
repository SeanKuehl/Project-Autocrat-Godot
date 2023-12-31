extends Control

#still need to do random length war/random war continue and also need to set up 
#getting rewards when you win/pop up event


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if GameData.GetWarStatus() == "War":
		var rebellionGainedPerTurn = -100
		var moneyLostPerTurn = -1000
		var rebellionPointsGained = GameData.GetTurnsAtWar() * rebellionGainedPerTurn
		var moneyLost = GameData.GetTurnsAtWar() * moneyLostPerTurn
		var surrenderMessage = "If you surrender now you gain " + str(rebellionPointsGained) + "\n and lose " +str(moneyLost) + "!"
		
		$SurrenderEffectsLabel.text = surrenderMessage
		
		$EasyWar.disabled = true
		$MediumWar.disabled = true
		$HardWar.disabled = true
		
	else:
		$EasyWar.disabled = false
		$MediumWar.disabled = false
		$HardWar.disabled = false

	var warDesc = "Each turn you are at war you will lose 500 security points.\n This will increase by 500 each turn until the war ends.\n If you run out of security points, you are conquered."
	$WarDescriptionLabel.text = warDesc




	



	
	
	
	


func _on_surrender_button_pressed():
	#if you surrender you lose money and gain rebellion points
	#more for longer you've been at war
	
	GameData.SetWarStatus("War Ended")
	


func _on_back_button_pressed():
	
	get_tree().change_scene_to_file("res://Menus/GameScreen.tscn")
	
	


func _on_easy_war_pressed():
	GameData.SetWarStatus("War")
	GameData.warDifficulty = "easy"


func _on_medium_war_pressed():
	GameData.SetWarStatus("War")
	GameData.warDifficulty = "medium"


func _on_hard_war_pressed():
	GameData.SetWarStatus("War")
	GameData.warDifficulty = "hard"
