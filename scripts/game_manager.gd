extends Node

@onready var score_label = $ScoreLabel
@onready var pause_menu = $"../CanvasLayer/PauseMenu"

var score = 0

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins"

func _ready():
	pause_menu.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_paused()


func toggle_paused():
	var tree = get_tree()
		
	if tree.paused:
		tree.paused = false
		pause_menu.hide()
	else:
		tree.paused = true
		pause_menu.show()


func _on_pause_menu_quit_game():
	toggle_paused()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_pause_menu_resume_game():
	toggle_paused()
