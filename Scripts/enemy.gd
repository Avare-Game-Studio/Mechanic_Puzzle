extends Area2D

@export var speed: float = 100.0
@export var distance: float = 200.0 # Ne kadar uzağa gidecek?

var start_pos: Vector2
var direction: int = 1

func _ready() -> void:
	start_pos = global_position
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	# İleri geri hareket mantığı
	position.x += speed * delta * direction
	
	# Başlangıç noktasından çok uzaklaştıysa geri dön
	if abs(position.x - start_pos.x) > distance:
		direction *= -1


func _on_body_entered(body: Node2D) -> void:
	# Artık isimle değil, grup üyeliğiyle kontrol ediyoruz
	if body.is_in_group("players"):
		print("DÜŞMAN YAKALADI! Oyun sıfırlanıyor...")
		get_tree().reload_current_scene()
