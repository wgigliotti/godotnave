extends RigidBody2D

@export var bullet_scene: PackedScene


@onready var cannon_shoot = $CannonShoot

var acceleration = 8000

var velocity = Vector2.DOWN 
var rotation_speed = 3.5
var shoot_freq = 1

var can_shoot = true
var cannon_left = true

var syncPosition = Vector2(0,0)
var syncRotation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.enabled = true if str(name).to_int() == multiplayer.get_unique_id() else false
	
	$Cannons/ShootTimer.wait_time = 1.0/shoot_freq
	
	print($Cannons/ShootTimer.wait_time)
	
	
	if str(name).to_int() != multiplayer.get_unique_id():
		$Controls.LeftKey = ""
		$Controls.RightKey = ""
		$Controls.ShootKey = ""
	$Controls/MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func shoot():
	print("shooting")
	var bullet = bullet_scene.instantiate()
	
	var cannon = $Cannons/CannonLeft.position.rotated(rotation) if cannon_left else $Cannons/CannonRight.position.rotated(rotation)
	cannon_left = !cannon_left

	bullet.position = position + cannon
	bullet.rotation = rotation
	bullet.velocity = velocity
	
	get_parent().add_child(bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func jet(particle, pressed, propNode):
	particle.emitting = false	
	if pressed:		
		particle.emitting = true		
		apply_force(Vector2.DOWN.rotated(rotation)*80000, propNode.get_position().rotated(rotation))
	
	
func _process(delta):	
	jet($Jets/LeftProp/Jet, $Controls.left, $Jets/LeftProp)
	jet($Jets/RightProp/Jet, $Controls.right, $Jets/RightProp)
	
	
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
