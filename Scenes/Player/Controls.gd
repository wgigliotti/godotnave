extends Node


@export var left = 0
@export var right = 0
@export var shoot = false

@export var LeftKey: String
@export var RightKey: String
@export var ShootKey: String
@export var LeftReverseKey: String
@export var RightReverseKey: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	shoot = true if Input.is_action_pressed(ShootKey) else false
	
	left = 0
	if Input.is_action_pressed(LeftReverseKey):
		left = -1
		
	if Input.is_action_pressed(LeftKey):
		left = 1
		
	#left = 1 if Input.is_action_pressed(LeftKey) else 0
	#left = -1 if Input.is_action_pressed(LeftReverseKey) else left
	
	right = 0
	
	if Input.is_action_pressed(RightReverseKey):
		right = -1
	if Input.is_action_pressed(RightKey):
		right = 1
	
	
	
	
