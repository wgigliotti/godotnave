extends Node


@export var left = 0
@export var right = 0
@export var shoot = false

@export var LeftKey: String
@export var RightKey: String
@export var ShootKey: String
@export var LeftReverseKey: String
@export var RightReverseKey: String

var backward_potency = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	shoot = true if ShootKey != "" and Input.is_action_pressed(ShootKey) else false
	
	left = 0
	
	if LeftReverseKey != "" and Input.is_action_pressed(LeftReverseKey):
		left = -backward_potency
		
	if LeftKey != "" and Input.is_action_pressed(LeftKey):
		left = 1
		
	#left = 1 if Input.is_action_pressed(LeftKey) else 0
	#left = -1 if Input.is_action_pressed(LeftReverseKey) else left
	
	right = 0
	
	if RightReverseKey != "" and Input.is_action_pressed(RightReverseKey):
		right = -backward_potency
	if RightKey != "" and Input.is_action_pressed(RightKey):
		right = 1
	
func to_left(direction : bool = true):	
	right = 0
	left = 1 if direction else -1 * backward_potency
	
func to_right(direction : bool = true):
	right = 1 if direction else -1 * backward_potency
	left = 0

func to_forward(direction : bool = true):
	right = 1 if direction else -1 * backward_potency
	left = 1 if direction else -1 * backward_potency
	


	
	
	
