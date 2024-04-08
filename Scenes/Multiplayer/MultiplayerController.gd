extends Control

@export var port = 8910

@export var SceneMap: PackedScene

var peer
# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func connected_to_server():
	print("Connected")
	GameManager.send_player_information.rpc_id(1, GameManager.player_info($nameLine.text, multiplayer.get_unique_id()),  multiplayer.get_unique_id())
	
func connection_failed():
	print("Connection Failed")
	
func peer_connected(id):
	print("Player connected " + str(id))
	
func peer_disconnected(id):
	print("Player disconnected " + str(id))

func _on_host_button_down():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	
	if error  != OK:
		print("Cannot Host")
		return
		
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players")
	
	GameManager.send_player_information(GameManager.player_info($nameLine.text, multiplayer.get_unique_id()),  multiplayer.get_unique_id())	

func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client($hostLine.text, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	pass # Replace with function body.

@rpc("any_peer", "call_local")
func start_game():
		var scene = SceneMap.instantiate()
		get_tree().root.add_child(scene)
		self.hide()


func _on_start_game_button_down():
	GameManager.send_player_information(GameManager.player_info("Bot", -1),  -1)	
	GameManager.send_player_information(GameManager.player_info("Bot", -2),  -2)
	start_game.rpc()
