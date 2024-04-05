extends ParallaxLayer


@export var shipScene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$NewShipTimer.wait_time = randf()*1
	$NewShipTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_ship_timer_timeout():
	var ship = shipScene.instantiate()
	
	ship.position = position + Vector2(randf_range(100,900), randf_range(100,600))
	ship.rotation = rotation
	ship.scale.x = 0.14
	ship.scale.y = 0.14
	
	
	add_child(ship)
	$NewShipTimer.wait_time = randf()*0.1
	$NewShipTimer.start()
