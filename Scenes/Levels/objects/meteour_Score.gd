extends RigidBody2D

var score = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var scored = false
	if multiplayer.is_server():
		for object in $Area2D.get_overlapping_bodies( ):
			if object.is_in_group("player"):
				scored = true
				update_score(object, delta*score)
				
	if scored:
		GameManager.update_players()

func update_score(player, score):
	GameManager.add_score(str(player.name).to_int(), score)
	
