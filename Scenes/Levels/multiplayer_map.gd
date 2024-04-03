extends Node


# Called when the node enters the scene tree for the first time.

@export var PlayerScene : PackedScene

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var index = 0
	var my_id = multiplayer.get_unique_id()
	
	for i in GameManager.players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.players[i].id)
		
		GameManager.players[i].ship = currentPlayer
		if my_id == i:
			player = currentPlayer
		
		add_child(currentPlayer)
		
		for spawn in get_tree().get_nodes_in_group("spawns_points"):
			if spawn.name == str(index):				
				currentPlayer.global_position = spawn.global_position
				
			index += 1
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Hud/position.text = str(player.global_position)
	$Hud/acceleration.text = str(player.shoot_freq)
	#print(player)
	
