@tool
extends Node2D

var dmg = 1

@onready var sprite = $SierraVerdadera/Sprite2D
@onready var path = $Path2D/PathFollow2D
@onready var sierra =$SierraVerdadera
@export var platformSpeed : float = .2
var isRigth = true



func _process(delta):
	sprite.rotate(deg_to_rad(450 * delta))
	sierra.global_position = path.global_position
	if isRigth:
		path.progress_ratio += platformSpeed * delta
	
	else :
		path.progress_ratio -= platformSpeed * delta
	
	if path.progress_ratio >= .95:
		isRigth = false
	
	elif path.progress_ratio <= .05:
		isRigth = true
	
	
	
	
	
	



func _on_dmg_player_body_entered(body):
	if body is Player:
		body.takeDamage(dmg)
