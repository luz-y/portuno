extends AnimatableBody2D

const VELOCITY = Vector2(0, -256)


func _physics_process(delta: float) -> void:
	var collider := move_and_collide(VELOCITY.rotated(rotation) * delta)
	
	if collider:
		queue_free()


func _on_hitbox_body_entered() -> void:
	queue_free()


func _on_hitbox_area_entered() -> void:
	EventBus.player_died.emit()
	queue_free()
