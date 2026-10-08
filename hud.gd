class_name HUD extends CanvasLayer

signal start_game

@onready var score_label: Label = $ScoreLabel
@onready var message_label: Label = $MessageLabel
@onready var start_button: Button = $StartButton
@onready var message_timer: Timer = $MessageTimer

func update_score1(score: int) -> void:
	score_label.text = "SCORE: " + str(score)
	
func show_game_over() -> void:
	show_message("Game Over!")
	await message_timer.timeout
	message_label.text = "Dodge the Creeps"
	message_label.show()
	start_button.show()

func show_message(message: String) -> void:
	message_label.text = message
	message_label.show()
	message_timer.start()

func _on_message_timer_timeout() -> void:
	message_label.hide()

func _on_start_button_pressed() -> void:
	message_label.hide()
	start_button.hide()
	start_game.emit()
