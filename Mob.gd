extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the name of all animations in an array
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# randi() generate a 'random' number between 0 and 4294967295 (inclusive)
	# The method size return the length of the array
	# Using the modulo operator with the randi and the length of the array the result cannot be equal or higher than the array length
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# Send a signal when the mob exit the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
