extends Node


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Player/world.tscn")


func _on_button_2_pressed():
	get_tree().quit()


func _on_button_3_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
