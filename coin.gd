extends RigidBody2D

func _ready():
	$AnimatedSprite2D.play("default")
	$DespawnTimer.start()
	


func _on_despawn_timer_timeout():
	queue_free()
