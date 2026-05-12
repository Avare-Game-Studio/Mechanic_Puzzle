extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var high_score_label: Label = $HighScoreLabel
@onready var game_over_panel: Control = $GameOverPanel
@onready var final_score_label: Label = $GameOverPanel/FinalScoreLabel

func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.game_over.connect(_on_game_over)
	game_over_panel.hide()
	_on_score_changed(GameManager.score, GameManager.high_score)

func _unhandled_input(event: InputEvent) -> void:
	if GameManager.is_game_over and event.is_action_pressed("ui_accept"):
		GameManager.restart_run()

func _on_score_changed(score: int, high_score: int) -> void:
	score_label.text = "Score: %d" % score
	high_score_label.text = "Best: %d" % high_score

func _on_game_over(score: int, high_score: int) -> void:
	final_score_label.text = "Score: %d  Best: %d" % [score, high_score]
	game_over_panel.show()
