extends Node2D

@export var PlayerScene : PackedScene

var ship
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$Camera2D.enabled = true if str(name).to_int() == multiplayer.get_unique_id() else false

func setShip(mship):
	self.ship = mship
	$Label.text = (GameManager.getPlayerInfo(ship.id)).name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	global_position = ship.global_position
