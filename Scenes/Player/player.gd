extends RigidBody2D

@export var bullet_scene: PackedScene

@onready var cannon_shoot = $CannonShoot

@export var left: String
@export var right: String
@export var up: String
@export var shoot_key: String

var acceleration = 200
var velocity = Vector2.DOWN 
var rotation_speed = 3.5

var can_shoot = true
var cannon_left = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot():
	print("shooting")
	var bullet = bullet_scene.instantiate()
	
	var cannon = $CannonLeft.position.rotated(rotation) if cannon_left else $CannonRight.position.rotated(rotation)
	cannon_left = !cannon_left
	
	print(cannon_left)
	
	bullet.position = position + cannon
	bullet.rotation = rotation
	bullet.velocity = velocity
	
	get_parent().add_child(bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func jet(particle, button, propNode):
	particle.emitting = false	
	if Input.is_action_pressed(button):		
		particle.emitting = true		
		apply_force(Vector2.DOWN.rotated(rotation)*80000, propNode.get_position().rotated(rotation))
	
	
func _process(delta):	
	jet($LeftProp/Jet, left, $LeftProp)
	jet($RightProp/Jet, right, $RightProp)
	
	
	if Input.is_action_pressed(shoot_key):
		if can_shoot == true:
			cannon_shoot.play()
			can_shoot = false
			$ShootTimer.start()
			shoot()
	
	


func _on_timer_timeout():
	can_shoot = true
