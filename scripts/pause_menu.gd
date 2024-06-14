extends Control

signal resume_game
signal quit_game


func _on_resume_pressed():
	resume_game.emit()


func _on_quit_pressed():
	quit_game.emit()
