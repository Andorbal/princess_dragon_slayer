extends Area2D

@onready var timer = $Timer
@onready var particles = $GPUParticles2D

func _on_body_entered(body):
	particles.global_position = body.global_position
	particles.emitting = true
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene() # Replace with function body.
