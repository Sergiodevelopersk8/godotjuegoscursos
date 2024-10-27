extends Node
@onready var settings_canvas_layer: CanvasLayer = $SettingsCanvasLayer

func _ready() :
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Maps/world.tscn")


func _on_button_2_pressed():
	get_tree().quit()


func _on_button_3_pressed():
	settings_canvas_layer.show()
