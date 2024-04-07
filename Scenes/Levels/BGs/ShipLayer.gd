extends ParallaxLayer


@export var shipScene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$NewShipTimer.wait_time = randf()*1
	$NewShipTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_ship_timer_timeout():
	var ship = shipScene.instantiate()
	
	ship.global_position = GameManager.player.global_position + Vector2(randf_range(-300,300), randf_range(-300,300))
	ship.rotation = randf()*2*PI - PI
	var shipScale = 0.05 + randf()*0.1
	ship.scale.x = shipScale
	ship.scale.y = shipScale
	
	
	add_child(ship)
	$NewShipTimer.wait_time = randf()*4
	$NewShipTimer.start()
