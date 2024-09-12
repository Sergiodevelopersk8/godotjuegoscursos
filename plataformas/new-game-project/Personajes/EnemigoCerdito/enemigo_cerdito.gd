extends personajes

var direccion = -1
@onready var raysuelo : RayCast2D = $Raycast/RayCastSuelo
@onready var rayMuro : RayCast2D = $Raycast/RayCastMuro
@onready var rayos  = $Raycast
@onready var raycastPlayer = $raycastPlayerDetector
@onready var anim = $AnimationPlayer
var player
var canChangeDirection = true
enum estados {ANGRY, PATRULLAR, MORIRSE}
var estadoActual = estados.PATRULLAR

func _ready():
	anim.play("walk")
	speed = 60


func _physics_process(delta):
	velocity.x = direccion * speed
	
	
	if !is_on_floor():
		velocity.y += 9
	move_and_slide()

func _process(delta):
	
	if player == null and raycastPlayer.is_colliding():
		var colision = raycastPlayer.get_collider()
		if colision.is_in_group("Player"):
			player = colision
			estadoActual = estados.ANGRY
	
	if estadoActual == estados.ANGRY and player != null:
		anim.play("runAngry")
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direccion = -1
		elif directionPlayer.x > 0:
			direccion = 1
		$Sprite2D.flip_h = true if direccion == 1 else false
	
	
	if estadoActual == estados.PATRULLAR:
		if canChangeDirection and (rayMuro.is_colliding() or  !raysuelo.is_colliding()):
			canChangeDirection = false
			$Raycast/RayTimer.start()
			direccion *= -1
			rayos.scale.x *= -1
	
		$Sprite2D.flip_h = true if direccion == 1 else false

func takeDmg(damage):
	vida -= damage
	if vida <= 0 :
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		estadoActual = estados.MORIRSE
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
	
	queue_free()




func _on_ray_timer_timeout():
	canChangeDirection = true
	pass # Replace with function body.



func _on_dmg_player_body_entered(body):
	if body is Player:
		body.takeDamage(dmg)
