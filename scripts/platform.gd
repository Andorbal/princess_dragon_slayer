extends Node2D

@export_range(0.0, 10.0) 
var speed: float = 1.0:
	get:
		return speed
	set(value):
		speed = value
		if animation_player != null:
			animation_player.speed_scale = speed

@onready var platform = $AnimatableBody2D
@onready var collision_shape = $AnimatableBody2D/CollisionShape2D
var animation_player: AnimationPlayer

func translate_position(pos: PlatformPosition, width: float, height: float):
	var top = pos.position.y + height
	if pos.alignment == PlatformPosition.PositionAlignment.LEFT:
		return Vector2(pos.position.x + width, top)
	elif pos.alignment == PlatformPosition.PositionAlignment.RIGHT:
		return Vector2(pos.position.x - width, top)
	else:
		return Vector2(pos.position.x, top)

func is_position(item):
	return item is PlatformPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	var animation = Animation.new()
	var shape = collision_shape.shape as RectangleShape2D
	var width = shape.size.x / 2
	var height = shape.size.y / 2
	
	var track = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track, str(platform.get_path()) + ":position")
	var time = 0.0
	
	var last_position: Vector2 = Vector2.INF
	var locations = get_children().filter(is_position)
	var distances = [0]
	var index = 0
	
	for i in range(1, locations.size()):
		var distance = abs(locations[i - 1].position.distance_to(locations[i].position))
		distances.push_back(distance)
	
	var total_distance = distances.reduce(func(prev, cur): return prev + cur, 0)

	for child in locations:
		var keyframe_position = translate_position(child, width, height)
		
		time += (distances[index] / total_distance) * 2
			
		var key_index = animation.track_insert_key(track, time, keyframe_position)
		#print("Added keyframe " + str(key_index) + " at " + str(time) + " for " + str(keyframe_position))
		animation.length = time
		index += 1
	
	if animation.track_get_key_count(track) > 0:
		# Make the platform loop smoothly
		animation.track_set_interpolation_type(track,Animation.INTERPOLATION_CUBIC)
		animation.track_set_interpolation_loop_wrap(track, true)
		animation.loop_mode = Animation.LOOP_PINGPONG
		
		animation_player = AnimationPlayer.new()
		animation_player.speed_scale = speed
		add_child(animation_player)
		
		var library = AnimationLibrary.new()
		library.add_animation("platform", animation)
		animation_player.add_animation_library("", library)
		animation_player.play("platform")
