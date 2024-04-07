extends RigidBody2D

var velocity = Vector2.DOWN
var acceleration = 9000000
# Called when the node enters the scene tree for the first time.
func _ready():
	apply_force(Vector2.DOWN.rotated(rotation)*acceleration*0.1)
	$BurstTimer.start()
	#velocity += Vector2.DOWN.rotated(rotation)*acceleration*0.1
	#$BurstTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	apply_force(Vector2.DOWN.rotated(rotation)*acceleration*delta)
#	velocity += Vector2.DOWN.rotated(rotation)*acceleration*delta
#	position += velocity * delta	


func _on_burst_timer_timeout():
	queue_free()
