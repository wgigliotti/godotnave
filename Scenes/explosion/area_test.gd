extends Area2D


signal explode
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_explosion_timer_timeout():
	visible = true
	$GPUParticles2D.emitting = true
	explode.emit(self)
	


func _on_gpu_particles_2d_finished():
	print("fim")
	queue_free()
