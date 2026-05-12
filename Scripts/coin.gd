extends Area2D

@export var score_value: int = 1

func _ready() -> void:
	# Sinyali kodla bağlayarak editör hatalarını devre dışı bırakıyoruz
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		GameManager.add_score(score_value)
		call_deferred("queue_free")

func free_coin() -> void:
	queue_free()
