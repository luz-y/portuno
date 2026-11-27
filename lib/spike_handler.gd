extends Node
## Helper singleton that handles spawning spike entities. 
## [br]
## Unlike setting cell directly in [TileMapLayer] with scene collection, 
## the singleton handles the tile's transform. 

enum SpikeType {
	STATIC_SPIKE = 1, ## Static spike type ID.
	FALLING_SPIKE, ## Falling spike type ID.
	HOMING_SPIKE, ## Homing spike type ID.
	SPIKE_MINE, ## Spike mine type ID.
	LEGGED_SPIKE, ## Legged spike type ID.
	GHOST_SPIKE, ## Ghost spike type ID.
}

## Spike type IDs mapped to spike entity scene.
const SPIKE_ENTITY_SCENES : Dictionary[SpikeType, PackedScene]= {
	SpikeType.FALLING_SPIKE : preload("uid://d2djvlxxljvjb"),
	SpikeType.HOMING_SPIKE : preload("uid://bm08yfheefo7n"),
	SpikeType.SPIKE_MINE : preload("uid://4lgmrgdghr2f"),
	SpikeType.LEGGED_SPIKE : preload("uid://sexn056pcak5"),
	SpikeType.GHOST_SPIKE : preload("uid://drkdce6hvnit7"),
}


## Instantiate the spike scene and set the transform based on the tile transform
## data. If the retrieved tile data is invalid then an error is generated and
## the operation failed. 
func spawn_spike(tile_map: TileMapLayer, cell_coords: Vector2i, type: SpikeType) -> void:
	if type == SpikeType.STATIC_SPIKE:
		push_warning("Static spike do not have entity scene. Function does nothing.")
		return
	
	var flipped_h := tile_map.is_cell_flipped_h(cell_coords)
	var flipped_v := tile_map.is_cell_flipped_v(cell_coords)
	var transposed := tile_map.is_cell_transposed(cell_coords)
	
	var rotation := 0.0
	
	if transposed and flipped_h and not flipped_v:
		rotation = PI / 2
	elif not transposed and flipped_h and flipped_v:
		rotation = PI
	elif transposed and not flipped_h and flipped_v:
		rotation = PI + PI / 2
	
	var spike : Node2D = SPIKE_ENTITY_SCENES[type].instantiate()
	
	if type == SpikeType.SPIKE_MINE:
		tile_map.add_child(spike)
	else:
		get_tree().current_scene.add_child(spike)
	
	if type != SpikeType.FALLING_SPIKE: # Don't rotate falling spike
		spike.rotation = rotation
	
	var cell_local_pos := tile_map.map_to_local(cell_coords)
	var cell_global_pos := tile_map.to_global(cell_local_pos)
	
	spike.global_position = cell_global_pos
