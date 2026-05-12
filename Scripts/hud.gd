extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var high_score_label: Label = $HighScoreLabel

func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)
	_on_score_changed(GameManager.score, GameManager.high_score)

func _on_score_changed(score: int, high_score: int) -> void:
	score_label.text = "Score: %d" % score
	high_score_label.text = "Best: %d" % high_score
