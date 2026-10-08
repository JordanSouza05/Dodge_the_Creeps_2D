class_name Enemy extends RigidBody2D

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	var animation_names = animated.sprite_frames.get_animation_names()
	var random_index = randi() % animation_names.size()
	animated.play(animation_names[random_index])


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Autodestruíndo...")
	queue_free()
