extends Node2D

@onready var sprite = $Warning

var check = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_parent().name == str(multiplayer.get_unique_id()):
		return
	
		
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()

	var now = Time.get_unix_time_from_system()
	
	#if now - check > 5:
	#	check = now		
	do_mark(Rect2(top_left, size))	

func do_mark(bounds : Rect2):
	if(bounds.has_point(global_position)):
		sprite.global_position = global_position
		return
	
	var bound = bounds.position
	var center = bounds.get_center()
	var r = bounds.size.x	
	
	var vct = global_position - center
	var vcb = bound - center
	
	var x = vcb.y/vct.y
	var y = (x*vct.x - vcb.x)/r
	
	var left = (y > 1 and x < 0) or (y < 0 and x > 0)
	if (y > 1 and x < 0) or (y < 0 and x > 0): 
		drawLeft(bounds, vct, center)
		return
		
	if (y > 1 and x > 0) or (y < 0 and x < 0): 
		drawRight(bounds, vct, center)
		return
		
	if(x > 0):		
		drawUP(bounds, bound + y * Vector2(r, 0))
	else:
		drawDown(bounds, vct, center)
		
	
	#print("****************")
	#print(get_parent().name)
	#print(bounds)
	#print(center)
	#print(bound)
	#print(global_position)
	#print(vr)
	#print(intersect)

func drawUP(bounds : Rect2, pos : Vector2):
	sprite.global_position = pos

func drawLeft(bounds : Rect2, vct : Vector2, center : Vector2):
	var pos = Geometry2D.line_intersects_line(bounds.position, Vector2(0, bounds.size.y), center, vct)
	sprite.global_position = pos
	
func drawRight(bounds : Rect2, vct : Vector2, center : Vector2):
	var pos = Geometry2D.line_intersects_line(bounds.position + Vector2(bounds.size.x,0), Vector2(0, bounds.size.y), center, vct)
	sprite.global_position = pos
	
func drawDown(bounds : Rect2, vct : Vector2, center : Vector2):
	var pos = Geometry2D.line_intersects_line(bounds.position + Vector2(0,bounds.size.y), Vector2(bounds.size.x, 0), center, vct)
	sprite.global_position = pos
	
func do_mark2(bounds : Rect2):
	#if(bounds.has_point(global_position)):
	#	hide()
	#	return
	
	show()
	sprite.global_position.x = clamp(global_position.x, bounds.position.x, bounds.end.x)
	sprite.global_position.y = clamp(global_position.y, bounds.position.y, bounds.end.y)
	
