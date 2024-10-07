@tool
extends Node2D

var dmg = 1

@onready var sprite = $SierraVerdadera/Sprite
@onready var path = $Path2D/PathFollow2D

func _process(delta):
	sprite.rotate(deg_to_rad(450 * delta))

func _on_dmg_player_body_entered(body):
	if body is Player:
		body.takeDamage(dmg)
