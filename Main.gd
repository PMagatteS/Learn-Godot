extends Node

# This allow us to choose the Mob scene we want to instance
@export var mob_scene: PackedScene
@export var coin_scene: PackedScene

var score
var goldCoin
var screenWidth = ProjectSettings.get_setting("display/window/size/viewport_width")
var screenHeight = ProjectSettings.get_setting("display/window/size/viewport_height")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func game_over():
	$Music.stop()
	$DeathSound.play()
	$CoinTimer.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	

func new_game():
	$Music.play()
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("coins", "queue_free")	
	score = 0
	goldCoin = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.update_coins(goldCoin)
	$HUD.show_message("Get Ready")

func _on_player_hit():
	game_over()


func _on_start_timer_timeout():
	$CoinTimer.start()
	$MobTimer.start()
	$ScoreTimer.start()
	


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	
	var mob = mob_scene.instantiate()

	
	
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	

	# Set the mob's direction perpendicular to the path direction.	 
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_player_coin_collected():
	score += 5 
	$HUD.update_score(score)
	goldCoin += 1
	$HUD.update_coins(goldCoin)


func _on_coin_timer_timeout():
	var coin = coin_scene.instantiate()
	var radius = coin.get_node("CollisionShape2D").shape.radius
	coin.position = Vector2(randf_range(radius, screenWidth-radius), randf_range(radius, screenHeight-radius))
	add_child(coin)

