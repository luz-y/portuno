extends AnimatableBody2D

var velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	var collider := move_and_collide(velocity * delta)
	if collider:
		queue_free()
	
	velocity += get_gravity() * delta
	velocity.y = minf(velocity.y, 800.0)


func _on_hitbox_area_entered() -> void:
	queue_free()
