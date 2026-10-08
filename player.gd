class_name Player extends Area2D

signal hit

@export var _speed: int = 400
@onready var animated: AnimatedSprite2D = %AnimatedSprite2D
var _screen_size: Vector2
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	_screen_size = get_viewport_rect().size
	hide()
	
func start(pos: Vector2) -> void:
	position = pos
	collision.disabled = false
	show()
	
func _process(delta) -> void:
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("action_up"):
		direction = Vector2.UP
	if Input.is_action_pressed("action_right"):
		direction = Vector2.RIGHT
	if Input.is_action_pressed("action_down"):
		direction = Vector2.DOWN
	if Input.is_action_pressed("action_left"):
		direction = Vector2.LEFT
		
	if direction != Vector2.ZERO:
		position += direction * _speed * delta
		
	position = position.clamp(Vector2.ZERO, _screen_size)
		
	_update_animations(direction)
		
func _update_animations(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		if direction.x != 0:
			animated.play("walk")
			animated.flip_h = direction.x < 0
			animated.flip_v = false
		if direction.y != 0:
			animated.play("up")
			animated.flip_v = direction.y > 0
			
	else:
		animated.stop()

func _on_body_entered(body: Node2D) -> void:
	hide()
	collision.set_deferred("disabled", true)
	hit.emit()
	
