extends Area2D
signal hit
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
func _ready():
	hide()
	screen_size = get_viewport_rect().size
	start(position)
	
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
#	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_right"
		#$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.x < 0:
		$AnimatedSprite2D.animation="walk_left"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
	elif velocity.y<0:
		$AnimatedSprite2D.animation = "walk_up"
	else:
		$AnimatedSprite2D.animation="idle"


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
func start(pos):
	print_debug('Starting player')
	position = pos
	show()
	$CollisionShape2D.disabled = false
	print_debug('leaving player start')
