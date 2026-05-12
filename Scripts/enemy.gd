extends Area2D

@export var speed: float = 100.0
@export var distance: float = 200.0 # Ne kadar uzağa gidecek?

var start_pos: Vector2
var direction: int = 1

func _ready() -> void:
	start_pos = position 
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	var current_speed = speed + (GameManager.score * 0.5)
	position.x += current_speed * delta * direction
	
	if abs(position.x - start_pos.x) > distance:
		direction *= -1
		$Sprite2D.flip_h = direction > 0


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("DÜŞMAN YAKALADI! Oyun sıfırlanıyor...")
		# Direkt çağırmak yerine, güvenli bir ana erteliyoruz:
		get_tree().call_deferred("reload_current_scene")
