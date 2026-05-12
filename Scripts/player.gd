extends CharacterBody2D

@export var speed: float = 300.0
@export var acceleration: float = 1800.0
@export var air_acceleration: float = 1100.0
@export var friction: float = 2200.0
@export var jump_velocity: float = -430.0
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.12
@export var dash_speed: float = 650.0
@export var dash_duration: float = 0.12
@export var dash_cooldown: float = 0.45

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0
var dash_direction: float = 1.0

func _ready() -> void:
	if InputMap.has_action("dash"):
		return

	InputMap.add_action("dash")
	var dash_key = InputEventKey.new()
	dash_key.physical_keycode = KEY_X
	InputMap.action_add_event("dash", dash_key)

func _physics_process(delta: float) -> void:
	if GameManager.is_game_over:
		velocity = Vector2.ZERO
		return

	dash_cooldown_timer = maxf(dash_cooldown_timer - delta, 0.0)

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0.0:
		dash_direction = direction

	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0.0:
		start_dash()

	if dash_timer > 0.0:
		dash_timer = maxf(dash_timer - delta, 0.0)
		velocity.x = dash_direction * dash_speed
		velocity.y = 0.0
		move_and_slide()
		check_fall_death()
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
	check_fall_death()

func start_dash() -> void:
	dash_timer = dash_duration
	dash_cooldown_timer = dash_cooldown

func check_fall_death() -> void:
	if global_position.y > 1500: 
		GameManager.end_run()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("Bir şey alana girdi!")
