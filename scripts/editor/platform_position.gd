@tool
extends Node2D
class_name PlatformPosition

const SIZE = 20
const THICKNESS = 0.1

enum PositionAlignment {
	LEFT,
	CENTER,
	RIGHT
}

var half_size = SIZE / 2.0

@export 
var alignment: PositionAlignment = PositionAlignment.LEFT:
	get:
		return alignment
	set(value):
		alignment = value
		queue_redraw()

func _ready():
	pass

func _draw():
	if Engine.is_editor_hint():
		draw_line(Vector2(0, 0), Vector2(0, SIZE), Color.WHITE, THICKNESS)
		
		if alignment == PositionAlignment.LEFT:
			draw_line(Vector2(0, 0), Vector2(SIZE, 0), Color.GREEN, THICKNESS)
		elif alignment == PositionAlignment.CENTER:
			draw_line(Vector2(-half_size, 0), Vector2(half_size, 0), Color.GREEN, THICKNESS)
		if alignment == PositionAlignment.RIGHT:
			draw_line(Vector2(-SIZE, 0), Vector2(0, 0), Color.GREEN, THICKNESS)

