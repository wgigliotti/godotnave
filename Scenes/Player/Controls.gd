extends Node


@export var left = false
@export var right = false
@export var shoot = false

@export var LeftKey: String
@export var RightKey: String
@export var ShootKey: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	shoot = true if Input.is_action_pressed(ShootKey) else false
	left = true if Input.is_action_pressed(LeftKey) else false
	right = true if Input.is_action_pressed(RightKey) else false
	
	
	
