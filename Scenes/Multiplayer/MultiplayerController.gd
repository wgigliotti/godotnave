extends Control

@export var port = 8910

@export var SceneMap: PackedScene

@export var bots: int

var peer
# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	
	for argument in OS.get_cmdline_args():
		if argument.begins_with("--bots"):
			var key_value = argument.split("=")
			bots = key_value[1].int()
	
	if OS.has_environment("USERNAME"):
		$nameLine.text = OS.get_environment("USERNAME")
	else:
		$nameLine.text = "Player " + str(randi_range(1, 200))
	
	if GameManager.is_dedicated_server():
		host()


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

func host():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	
	if error  != OK:
		print("Cannot Host")
		return
		
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players")
	
func _on_host_button_down():
	host()	
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

@rpc("any_peer")
func server_start():
	for n in bots:
		GameManager.send_player_information(GameManager.player_info("Bot %d" % n , -n),  -n)	
		
	start_game.rpc()
		
func _on_start_game_button_down():
	if multiplayer.is_server():
		server_start()
	else:
		server_start.rpc_id(1)
