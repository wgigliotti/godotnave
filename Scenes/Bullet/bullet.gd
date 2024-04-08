extends RigidBody2D

var velocity = Vector2.DOWN
var acceleration = 90000000

func _ready():
	apply_force(Vector2.DOWN.rotated(rotation)*acceleration*0.1)
	$BurstTimer.start()

func _process(delta):	
	apply_force(Vector2.DOWN.rotated(rotation)*acceleration*delta)

func _on_burst_timer_timeout():
	queue_free()
