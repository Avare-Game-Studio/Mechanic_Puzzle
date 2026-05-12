extends CharacterBody2D

@export var speed: float = 300.0
@export var acceleration: float = 1800.0
@export var air_acceleration: float = 1100.0
@export var friction: float = 2200.0
@export var jump_velocity: float = -430.0
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.12

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0

func _physics_process(delta: float) -> void:
	if GameManager.is_game_over:
		velocity = Vector2.ZERO
		return

	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer = maxf(coyote_timer - delta, 0.0)
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer = maxf(jump_buffer_timer - delta, 0.0)

	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		velocity.y = jump_velocity
		jump_buffer_timer = 0.0
		coyote_timer = 0.0

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		var current_acceleration = acceleration if is_on_floor() else air_acceleration
		velocity.x = move_toward(velocity.x, direction * speed, current_acceleration * delta)
		if direction > 0:
			$Sprite2D.flip_h = false 
		elif direction < 0:
			$Sprite2D.flip_h = true 
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()
	if global_position.y > 1500: 
		GameManager.end_run()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("Bir şey alana girdi!")
