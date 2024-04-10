extends CanvasLayer

var player

@onready var scores = $ScorePanel/Scores

#func setPlayer(player_to_set):
#	player = player_to_set
# Called when the node enters the scene tree for the first time.
func _ready():
	createLabels(GameManager.players.values())
	
#	var id = multiplayer.get_unique_id()
#	player = GameManager.players[id].ship


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$deltaLabel.text = "Delta: " + str(delta)
	$acceleration.text = str(GameManager.player.shoot_freq)
	$scoreLabel.text = "Score: " + str(GameManager.getCurrentPlayerInfo().score)	


func _on_refresh_score_timeout():
	for child in scores.get_children():
		if child.is_in_group("score"):
			child.queue_free()
	
	var players = GameManager.players.values()
	players.sort_custom(func(a, b): return a.score > b.score)
	
	createLabels(players)
	
func createLabels(players):
	for player in players:
		var score_lbl = Label.new()
		
		score_lbl.text = "%s: %d" % [player.name, player.score]
		score_lbl.add_to_group("score")
		scores.add_child(score_lbl)
		


func _on_refresh_ping_timeout():
	GameManager.ping.rpc_id(1, Time.get_ticks_msec())	
	$pingLabel.text = "Ping: " + str(GameManager.ping_time)
