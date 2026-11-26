extends Node2D

const RANGE = 192.0

var ray_query := PhysicsRayQueryParameters2D.new()


func _init() -> void:
	ray_query.collide_with_areas = true
	ray_query.collision_mask = 1 # Obstacle mask


func _on_timer_timeout() -> void:
	queue_free()
	
	var player := get_tree().get_first_node_in_group(&"player") as Node2D
	
	if player == null:
		return
	
	var distance := global_position.distance_squared_to(player.global_position)
	
	if distance > RANGE ** 2:
		return
	
	ray_query.from = global_position
	ray_query.to = player.global_position
	
	var space_state := get_world_2d().direct_space_state
	var result := space_state.intersect_ray(ray_query)
	
	if result:
		return
	
	EventBus.player_died.emit()
