class_name Main extends Node2D

signal hit

@export var enemy_scene: PackedScene
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@onready var start_position: Marker2D = $StartPosition
@onready var enemy_timer: Timer = $EnemyTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var player: Player = $Player
@onready var hud: HUD = $HUD
@onready var music: AudioStreamPlayer = $MusicAudioStream
@onready var game_over_sfx: AudioStreamPlayer = $GameOverAudioStream

var score: int = 0

func start_game() -> void:
	print("Start Game")
	score = 0
	get_tree().call_group("enemies", "queue_free")
	enemy_timer.start()
	score_timer.start()
	music.play()
	player.start(start_position.position)

func game_over() -> void:
	hud.show_game_over()
	music.stop()
	game_over_sfx.play()
	enemy_timer.stop()
	score_timer.stop()
	
func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	path_follow.progress_ratio = randf()
	enemy.position = path_follow.position
	
	var direction = path_follow.rotation
	direction += PI / 2
	direction += randf_range(-PI / 4, PI  / 4)
	enemy.rotation = direction
	
	var velocity =  Vector2(randf_range(120.0, 220.0), 0)
	enemy.linear_velocity = velocity.rotated(enemy.rotation)
	
	add_child(enemy)

func _on_score_timer_timeout() -> void:
	score += 1
	hud.update_score1(score)
	print("Score: ", score)

func _on_player_hit() -> void:
	game_over()

func _on_hud_start_game() -> void:
	start_game()
