extends Node2D

var rotation_dir = 0
var speed = 300
var state = -1 # -1 Growing, 0 Walking, 1 Die
var start_time
var animation_time = 2

func showing():
	var delta = (Time.get_unix_time_from_system() - start_time)/2
	$Sprite2D.scale.x = delta
	$Sprite2D.scale.y = delta
	
	if delta >= 1:
		state = 0
	
func die():
	var delta = (Time.get_unix_time_from_system() - start_time)/2
	
	if delta >= 1:
		queue_free()
		return
		
	$Sprite2D.scale.x = 1-delta
	$Sprite2D.scale.y = 1-delta

	
# Called when the node enters the scene tree for the first time.
func _ready():
	retime()
	start_time = Time.get_unix_time_from_system()
	$LifeTime.wait_time = 2.5 + randf()*1
	$LifeTime.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += rotation_dir*delta
	var velocity = Vector2.DOWN.rotated(rotation) * speed * delta
	position += velocity
	
	if state == -1:
		showing()
	if state == 1:
		die()
	

func retime():
	$Timer.wait_time = randf()*1.5
	$Timer.start()

func _on_timer_timeout():
	if rotation_dir == 0:
		rotation_dir = (randf() * 2 * PI) - PI
	else:
		rotation_dir = 0
	retime()
	

func _on_life_time_timeout():
	start_time = Time.get_unix_time_from_system()
	state = 1
