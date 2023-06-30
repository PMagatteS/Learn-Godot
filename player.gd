extends Area2D
signal hit
signal coinCollected

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var frames = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
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

	# Length method return the magnitude of the verctor.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	# Clamp take 3 paramerter the value the minimum and the maximum and return a 'Variant' not less then the minimum parameter and not more then the maximum one.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	# Check wich animation to use 
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	# Personnal addition to check some values at a resonable rate
	if frames%60 == 0:
		#print("print something each second")
		pass
		
	frames+=1


func _on_body_entered(body):
	if "coin" in body.name :
		body.collected()
		coinCollected.emit()
	else:
		hide() # Player disappears after being hit.
		hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
