extends RigidBody2D

func _ready():
	$AnimatedSprite2D.play("default")
	$DespawnTimer.start()
	
	
	
func _on_despawn_timer_timeout():
	var disappear = get_tree().create_tween()
	disappear.tween_property(self, "modulate:a", 0, .25)
	disappear.tween_callback(queue_free)

func collected():
	var moveUp = get_tree().create_tween()
	var disappear = get_tree().create_tween()
	moveUp.tween_property(self, "position", position-Vector2(0, 20), .25)
	disappear.tween_property(self, "modulate:a", 0, .25)
	moveUp.tween_callback(queue_free)

