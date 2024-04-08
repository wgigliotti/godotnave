extends Node

var players = {}

var player
var id


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getPlayerInfo(mid):
	return players[mid]
	
func getCurrentPlayerInfo():
	return players[id]
	
func create_player(PlayerScene, UIScene, node, id):
	var currentPlayer = PlayerScene.instantiate()
	currentPlayer.name = str(id)	
	currentPlayer.add_to_group("player")
		
	if multiplayer.get_unique_id() == id:
		player = currentPlayer
		self.id = id
	
	node.add_child(currentPlayer)
	
	var ui = UIScene.instantiate()
	ui.setShip(currentPlayer)
	
	node.add_child(ui)
	
	return currentPlayer
	
func add_score(playerid, score):
	players[playerid].score += score

func update_players():
	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_information.rpc(GameManager.players[i], i)
			
func player_info(mname, id):
	return {
			"name": mname,
			"id": id,
			"score": 0
		}
	
@rpc("any_peer")
func send_player_information(player_info, id):
	GameManager.players[id] = player_info
		
	update_players()
