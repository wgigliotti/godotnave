extends RigidBody2D

@export var bullet_scene: PackedScene

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
	
	var cannon = $Cannons/CannonLeft.position.rotated(rotation) if cannon_left else $Cannons/CannonRight.position.rotated(rotation)
	cannon_left = !cannon_left
	
	print(cannon_left)
	
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
			can_shoot = false
			$Cannons/ShootTimer.start()
			shoot()


func _on_timer_timeout():
	can_shoot = true
