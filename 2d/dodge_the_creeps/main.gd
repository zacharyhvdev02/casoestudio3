extends Node

@export var mob_scene: PackedScene
var score
var messageManager: MessageManager

func game_over():
	# if the player was just hit, ignore.
	print("players inmunity: " + str($Player.recoveryInmunity))
	if $Player.recoveryInmunity:
		print("player is inmune")
		return

	if $Player.health > 1:
		print("player was hit")
		$Player.health -= 1
		messageManager.notify()
		$Player.recoveryInmunity = true
		$NoHitTimer.start()
	else:
		$Player.hide() # Player disappears after being hit.
		$ScoreTimer.stop()
		$MobTimer.stop()
		$HUD.show_game_over()
		$Music.stop()
		$DeathSound.play()
		$Player.get_node("CollisionShape2D").set_deferred(&"disabled", true)

func win():
		$Player.hide() # Player disappears after being hit.
		$ScoreTimer.stop()
		$MobTimer.stop()
		$HUD.show_win()
		$Music.stop()
		$WinSound.play()
		$Player.get_node("CollisionShape2D").set_deferred(&"disabled", true)

func new_game():
	
	get_tree().call_group(&"mobs", &"queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Player.score = score
	$HUD.show_message("Get Ready")
	$Music.play()
	$NoHitTimer.stop()

	var player = $Player
	player.health = 3

	messageManager = MessageManager.new(player)
	var healthObserver = HealthObserver.new($HUD)

	messageManager.add(healthObserver)
	messageManager.add(ScoreObserver.new($HUD))
	messageManager.notify()


func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node(^"MobPath/MobSpawnLocation")
	mob_spawn_location.progress = randi()

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

func _on_ScoreTimer_timeout():
	score += 1
	$Player.score += 1
	messageManager.notify()

func _on_NoHit_timeout():
	print("removing player inmunity")
	$Player.recoveryInmunity = false
	$NoHitTimer.stop()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
