extends RigidBody2D

@export var bullet_scene: PackedScene


@onready var cannon_shoot = $CannonShoot

var acceleration = 16000

var rotation_speed = 3.5
var shoot_freq = 1

var can_shoot = true
var cannon_left = true

var syncPosition = Vector2(0,0)
var syncRotation = 0

var id

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.enabled = true if str(name).to_int() == multiplayer.get_unique_id() else false
	id = str(name).to_int()
	
	$Cannons/ShootTimer.wait_time = 1.0/shoot_freq
	
	
	if str(name).to_int() != multiplayer.get_unique_id():
		$Controls.LeftKey = ""
		$Controls.RightKey = ""
		$Controls.ShootKey = ""
	$Controls/MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

	
func shoot():
	var bullet = bullet_scene.instantiate()
	
	var cannon = $Cannons/CannonLeft.position.rotated(rotation) if cannon_left else $Cannons/CannonRight.position.rotated(rotation)
	cannon_left = !cannon_left

	bullet.position = position + cannon
	bullet.rotation = rotation
	bullet.linear_velocity = Vector2.DOWN.rotated(rotation)*100 + linear_velocity
	
	get_parent().add_child(bullet)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func jet(particle, force, propNode):
	particle.emitting = false	
	if force != 0:		
		particle.emitting = true		
		apply_force(Vector2.DOWN.rotated(rotation)*acceleration*force, propNode.get_position().rotated(rotation))

func getControls():
	return $Controls
	
func _process(delta):	
	jet($Jets/LeftProp/Jet, $Controls.left, $Jets/LeftProp)
	jet($Jets/RightProp/Jet, $Controls.right, $Jets/RightProp)
	
	var zoom = (1/(linear_velocity.length()/2000 + 1))/2
	$Camera2D.zoom = Vector2(zoom, zoom)
	
	if $Controls.shoot:
		if can_shoot == true:
			cannon_shoot.play()
			can_shoot = false
			$Cannons/ShootTimer.wait_time = 1.0/shoot_freq			
			$Cannons/ShootTimer.start()
			shoot()

	if multiplayer.get_unique_id() == 1:
		syncPosition = global_position
		syncRotation = rotation_degrees
	else:
		global_position = global_position.lerp(syncPosition, 0.5)
		rotation_degrees = syncRotation


func _on_timer_timeout():
	can_shoot = true
	
func getPW(power):
	shoot_freq *= power
