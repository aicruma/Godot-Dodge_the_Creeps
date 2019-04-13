extends RigidBody2D

export (int) var MIN_SPEED
export (int) var MAX_SPEED
var mob_types = ["walk","swim","fly"]

# class member variables go here, for example:
# var a = 21
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_Visibility_screen_exited():
	queue_free()