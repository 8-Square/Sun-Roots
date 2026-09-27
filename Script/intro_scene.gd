class_name Intro extends Control

@onready var menu_click: AudioStreamPlayer = $MenuClick


func _on_play_button_pressed() -> void:
	menu_click.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scene/MainScene.tscn")


func _on_quit_button_pressed() -> void:
	menu_click.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()
