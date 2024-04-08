extends CanvasLayer

var player


#func setPlayer(player_to_set):
#	player = player_to_set
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	var id = multiplayer.get_unique_id()
#	player = GameManager.players[id].ship


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$deltaLabel.text = "Delta: " + str(delta)
	$acceleration.text = str(GameManager.player.shoot_freq)
	$scoreLabel.text = "Score: " + str(GameManager.getCurrentPlayerInfo().score)	
