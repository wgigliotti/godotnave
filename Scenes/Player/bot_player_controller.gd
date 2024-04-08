extends Node


var ship
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func setShip(mship):
	self.ship = mship

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var objective = getNearestObjective()
	var direction = Vector2.DOWN.rotated(ship.rotation)
	shoot(direction)
	
	if objective == null:
		return
		
	
	
	var to_objective = objective.global_position - ship.global_position
	var angle = direction.angle_to(to_objective)
	
	if(abs(angle) < 0.1):
		ship.getControls().to_forward()
		return
		
	if(angle > 0):
		ship.getControls().to_left()
	else:
		ship.getControls().to_right()
	
	
	
func getNearestObjective():
	var nearest = null
	var mindistance = null
	for objective in get_tree().get_nodes_in_group("objective"):
		var distance = ship.global_position.distance_squared_to(objective.global_position)
		if nearest == null or distance < mindistance:
			nearest = objective
			mindistance = distance
					
	return nearest
	
func shoot(direction):
	
	for target in get_tree().get_nodes_in_group("player"):
		if ship == target:
			continue
		
		var to_objective = target.global_position - ship.global_position
		var angle = direction.angle_to(to_objective)
		
		if abs(angle) < 0.1:
			ship.getControls().shoot = true
			return 
			
	ship.getControls().shoot = false
