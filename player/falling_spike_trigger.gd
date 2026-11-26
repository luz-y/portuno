extends RayCast2D


func _physics_process(_delta: float) -> void:
	if not is_colliding():
		return
	# This is null if casting failed
	var collider := get_collider() as TileMapLayer
	
	if collider == null:
		return
	
	var tile_rid := get_collider_rid()
	var coords := collider.get_coords_for_body_rid(tile_rid)
	var data : TileData = collider.get_cell_tile_data(coords)
	var is_falling_spike : bool = (
			data != null
			and data.has_custom_data("spike_type")
			and data.get_custom_data("spike_type") == SpikeHandler.SpikeType.FALLING_SPIKE
	)
	
	if is_falling_spike:
		SpikeHandler.spawn_spike(collider, coords, SpikeHandler.SpikeType.FALLING_SPIKE)
		collider.erase_cell(coords)
