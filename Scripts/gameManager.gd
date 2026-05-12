extends Node

signal score_changed(score: int, high_score: int)

var score: int = 0
var high_score: int = 0

func _ready() -> void:
	reset_score()

func add_score(amount: int) -> void:
	score += amount
	if score > high_score:
		high_score = score
	score_changed.emit(score, high_score)

func reset_score() -> void:
	score = 0
	score_changed.emit(score, high_score)
