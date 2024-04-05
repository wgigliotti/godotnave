extends Node2D


# Called when the node enters the scene tree for the first time.

@export var PlayerScene : PackedScene
@export var BombScene: PackedScene

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
			

func _on_explode_bomb(area):
	print("AREAS")
	for areas in area.get_overlapping_areas( ):
		print(areas.name)
		
	for areas in area.get_overlapping_bodies( ):
		print(areas.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Hud/position.text = str(player.global_position)
	$Hud/acceleration.text = str(player.shoot_freq)
	
	if Input.is_action_just_pressed("mouse_click"):
		var area = BombScene.instantiate()
		area.global_position = get_global_mouse_position()
		area.explode.connect(_on_explode_bomb)
		#area.connect("explode", self, _on_explode_bomb)
		add_child(area)
				
		print("AREAS")
		for areas in $AreaTest.get_overlapping_areas( ):
			print(areas.name)
			
		for areas in $AreaTest.get_overlapping_bodies( ):
			print(areas.name)
		
	#print(player)
	
