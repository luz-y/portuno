extends CharacterBody2D

const SPEED = 320.0
const ACCELERATION = 480.0
const DECELERATION = 640.0
const TURN_DEADZONE = 12.0

var _player: Node2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.y = minf(velocity.y, 800)
	
	if not is_instance_valid(_player):
		_player = get_tree().get_first_node_in_group(&"player") as Node2D
	
	var target_velocity := 0.0
	if is_instance_valid(_player):
		var dx := _player.global_position.x - global_position.x
		if absf(dx) > TURN_DEADZONE:
			target_velocity = signf(dx) * SPEED
	
	var is_reversing := target_velocity != 0.0 and signf(velocity.x) != 0.0 and signf(velocity.x) != signf(target_velocity)
	var rate := DECELERATION if (target_velocity == 0.0 or is_reversing) else ACCELERATION
	
	velocity.x = move_toward(velocity.x, target_velocity, rate * delta)
	move_and_slide()


func _on_hitbox_area_entered() -> void:
	EventBus.player_died.emit()
