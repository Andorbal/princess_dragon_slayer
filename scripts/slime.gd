extends Node2D

const SPEED = 60

@onready var animated_sprite = $AnimatedSprite2D
@onready var raycast_right = $RaycastRight
@onready var raycast_left = $RaycastLeft
var direction = 1;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if raycast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if raycast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta
