@tool
extends Path2D

@export var platformSpeed : float = .2

func _process(delta):
	#if Engine.is_editor_hint():#corre en el editor
	if not Engine.is_editor_hint(): #solo en el juego
		$PlatformCharacter.global_position = $PathFollow2D.global_position
	
		if $PathFollow2D.progress_ratio < 1:
			$PathFollow2D.progress_ratio += platformSpeed * delta
		else:
			$PathFollow2D.progress_ratio = 0
