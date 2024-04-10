extends RigidBody2D

var score = 1000000.0

var syncPosition = Vector2(0,0)
var syncRotation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var scored = false
	if multiplayer.is_server():
		for object in $Area2D.get_overlapping_bodies( ):
			if object.is_in_group("player"):
				var dist = global_position.distance_squared_to(object.global_position)
				scored = true
				update_score(object, delta*score/dist)
				
	if scored:
		GameManager.update_players()
		
	if multiplayer.get_unique_id() == 1:
		syncPosition = global_position
		syncRotation = rotation_degrees
	else:
		global_position = global_position.lerp(syncPosition, 0.5)
		rotation_degrees = syncRotation

func update_score(player, score):
	GameManager.add_score(str(player.name).to_int(), score)
	
