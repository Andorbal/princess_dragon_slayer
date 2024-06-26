extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const COYOTE_LENGTH = 0.025

@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_falling = true
var coyote_time = 0;


func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		is_falling = false
	elif is_falling or coyote_time > COYOTE_LENGTH:
		is_falling = true
		coyote_time = 0
		velocity.y += gravity * delta
	else:
		coyote_time += delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and not is_falling:
		velocity.y = JUMP_VELOCITY
		is_falling = true
		coyote_time = 0

	# Gets input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
