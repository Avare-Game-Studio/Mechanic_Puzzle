extends Node

signal score_changed(score: int, high_score: int)
signal game_over(score: int, high_score: int)

const SAVE_PATH = "user://save.cfg"

var score: int = 0
var high_score: int = 0
var is_game_over: bool = false

func _ready() -> void:
	load_progress()
	reset_score()

func add_score(amount: int) -> void:
	if is_game_over:
		return

	score += amount
	if score > high_score:
		high_score = score
		save_progress()
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

func load_progress() -> void:
	var save_file = ConfigFile.new()
	var error = save_file.load(SAVE_PATH)
	if error != OK:
		return

	high_score = int(save_file.get_value("progress", "high_score", 0))

func save_progress() -> void:
	var save_file = ConfigFile.new()
	save_file.set_value("progress", "high_score", high_score)
	save_file.save(SAVE_PATH)
