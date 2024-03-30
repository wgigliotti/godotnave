extends Control

@export var address = "127.0.0.1"
@export var port = 8910

var peer
# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func connected_to_server():
	print("Connected")
	
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
	
	

func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	pass # Replace with function body.

@rpc("any_peer", "call_local")
func start_game():
		var scene = load("res://main.tscn").instantiate()
		get_tree().root.add_child(scene)
		self.hide()

@rpc("any_peer", "call_local")
func send_player_information(name, id):
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": name,
			"id": id,
			"score": 0
		}
		
	if multiplayer.is_server():
		for i in GamaManager.players:
			send_player_information.rpc(GamaManager.players[id], id)


func _on_start_game_button_down():
	start_game.rpc()
