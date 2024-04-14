extends Node2D


# Called when the node enters the scene tree for the first time.

@export var PlayerScene : PackedScene
@export var BotScene : PackedScene
@export var UIScene : PackedScene
@export var BombScene: PackedScene

var player

func createBot(player):
	var bot = BotScene.instantiate()
	bot.setShip(player)
	add_child(bot)
# Called when the node enters the scene tree for the first time.
func _ready():
		
	for i in PlayerManager.players:
		
		var currentPlayer = GameManager.create_player(PlayerScene, UIScene, self, i)
		
		if PlayerManager.players[i].name.begins_with("Bot"):
			createBot(currentPlayer)
		
		var pos = Vector2.UP.rotated(randf_range(-PI, PI))* 25000
		currentPlayer.global_position = pos
		
	if PlayerManager.is_dedicated_server():
		$Hud.queue_free()
			
	

func _on_explode_bomb(area):
	print("AREAS")
	for areas in area.get_overlapping_areas( ):
		print(areas.name)
		
	for areas in area.get_overlapping_bodies( ):
		print(areas.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#$Hud/CanvasLayer/position.text = str(GameManager.player.global_position)
	#$Hud/CanvasLayer/acceleration.text = str(GameManager.player.shoot_freq)
	
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
	
