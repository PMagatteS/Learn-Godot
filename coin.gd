extends RigidBody2D

func _ready():
	print("new coin")
	$AnimatedSprite2D.play("default")
	$DespawnTimer.start()
	


func _on_despawn_timer_timeout():
	queue_free()
