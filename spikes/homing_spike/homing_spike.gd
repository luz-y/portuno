extends AnimatableBody2D

const SPEED := 128.0
const VELOCITY := Vector2(0, -SPEED)
const ANGULAR := TAU


func _physics_process(delta: float) -> void:
	var player := get_tree().get_first_node_in_group(&"player") as Node2D
	
	if player != null:
		var to_player := player.global_position - global_position
		var target_angle := to_player.angle() + PI / 2.0
		rotation = rotate_toward(rotation, target_angle, ANGULAR * delta)
	
	var collider := move_and_collide(VELOCITY.rotated(rotation) * delta)
	if collider:
		queue_free()


func _on_hitbox_area_entered() -> void:
	EventBus.player_died.emit()
	queue_free()
