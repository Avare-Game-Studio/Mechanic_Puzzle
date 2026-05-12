extends Node

signal score_changed(score: int, high_score: int)
signal game_over(score: int, high_score: int)

var score: int = 0
var high_score: int = 0
var is_game_over: bool = false

func _ready() -> void:
	reset_score()

func add_score(amount: int) -> void:
	if is_game_over:
		return

	score += amount
	if score > high_score:
		high_score = score
	score_changed.emit(score, high_score)

func reset_score() -> void:
	score = 0
	is_game_over = false
	score_changed.emit(score, high_score)

func end_run() -> void:
	if is_game_over:
		return

	is_game_over = true
	game_over.emit(score, high_score)

func restart_run() -> void:
	reset_score()
	get_tree().reload_current_scene.call_deferred()
