extends CharacterBody2D


func _physics_process(_delta: float) -> void:
	velocity = Vector2(0, -256).rotated(rotation)
	
	move_and_slide()


func _on_hitbox_body_entered() -> void:
	queue_free()


func _on_hitbox_area_entered() -> void:
	print("Dead") # Temporary
