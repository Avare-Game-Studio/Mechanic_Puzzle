extends Area2D

@export var score_value: int = 1

var is_collected: bool = false

func _ready() -> void:
	# Sinyali kodla bağlayarak editör hatalarını devre dışı bırakıyoruz
	body_entered.connect(_on_body_entered)
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players") and not GameManager.is_game_over and not is_collected:
		is_collected = true
		GameManager.add_score(score_value)
		$CollisionShape2D.set_deferred("disabled", true)
		play_collect_feedback()

func free_coin() -> void:
	queue_free()

func play_collect_feedback() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 24.0, 0.18)
	tween.tween_property(self, "scale", scale * 1.25, 0.12)
	tween.tween_property(self, "modulate:a", 0.0, 0.18)
	tween.chain().tween_callback(queue_free)
