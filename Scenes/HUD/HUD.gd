extends CanvasLayer


var player

func setPlayer(player_to_set):
	player = player_to_set
# Called when the node enters the scene tree for the first time.
func _ready():
	var id = multiplayer.get_unique_id()
	player = GameManager.players[id].ship


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#$position.text = player.global_position
	pass
