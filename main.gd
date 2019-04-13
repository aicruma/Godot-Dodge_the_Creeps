extends Node

export (PackedScene) var Mob
var score
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func new_game():
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$Music.play()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func _on_MobTimer_timeout():
	# choose a random location on Path2D
    $MobPath/MobSpawnLocation.set_offset(randi())
    # create a Mob instance and add it to the scene
    var mob = Mob.instance()
    add_child(mob)
    # set the mob's direction perpendicular to the path direction
    var direction = $MobPath/MobSpawnLocation.rotation + PI/2
    # set the mob's position to a random location
    mob.position = $MobPath/MobSpawnLocation.position
    # add some randomness to the direction
    direction += rand_range(-PI/4, PI/4)
    mob.rotation = direction
    # choose the velocity
    mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)



