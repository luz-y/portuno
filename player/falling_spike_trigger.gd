extends RayCast2D


func _physics_process(_delta: float) -> void:
	if not is_colliding():
		return
	# This is null if casting failed
	var collider := get_collider() as TileMapLayer
	
	if collider == null:
		return
	# The collision point is a blank space below touched tile so add one tile up.
	var tile_pos := collider.local_to_map(collider.to_local(get_collision_point())) + Vector2i.UP
	var tile_data := collider.get_cell_tile_data(tile_pos)
	
	if (
			tile_data != null 
			and tile_data.has_custom_data("spike_type") 
			and tile_data.get_custom_data("spike_type")
	):
		collider.set_cell(tile_pos, 1, Vector2.ZERO, 1)
