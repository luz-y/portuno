extends Area2D

var tiles : Dictionary[RID, Dictionary] = {}
var ray_query := PhysicsRayQueryParameters2D.new()
@onready var player : Node2D = get_parent()


func _init() -> void:
	ray_query.collide_with_areas = true
	ray_query.collision_mask = 1 | 1 << 6


func _physics_process(_delta: float) -> void:
	if tiles.is_empty():
		return
	
	ray_query.from = global_position
	#$Line2D.set_point_position(0, $Line2D.to_local(global_position))
	
	for tile in tiles:
		var tile_info := tiles[tile]
		var tile_map : TileMapLayer = tile_info[&"tile_map"]
		var tile_pos : Vector2i = tile_info[&"pos"]
		var type : int = tile_info[&"type"]
		
		if type == SpikeHandler.SpikeType.GHOST_SPIKE:
			SpikeHandler.spawn_spike(tile_map, tile_pos, type)
			tile_map.erase_cell(tile_pos)
			return
		
		var tile_local_pos := tile_map.map_to_local(tile_pos)
		var tile_global_pos := tile_map.to_global(tile_local_pos)
		
		#$Line2D.set_point_position(1, $Line2D.to_local(tile_global_pos))
		
		ray_query.to = tile_global_pos
		
		var space_state := get_world_2d().direct_space_state
		var result := space_state.intersect_ray(ray_query)
		
		if result:
			continue
		
		SpikeHandler.spawn_spike(tile_map, tile_pos, type)
		tile_map.erase_cell(tile_pos)


func _on_body_shape_entered(body_rid: RID, body: Node2D) -> void:
	if body is not TileMapLayer:
		return
	
	body = body as TileMapLayer # Tooltip help
	
	var coords = body.get_coords_for_body_rid(body_rid)
	var data = body.get_cell_tile_data(coords)
	
	if data == null or not data.has_custom_data("spike_type"):
		return
	
	var type : int = data.get_custom_data("spike_type")
	
	if type < SpikeHandler.SpikeType.HOMING_SPIKE:
		return
	
	tiles[body_rid] = {
		&"tile_map" : body,
		&"pos" : coords,
		&"type" : type,
	}


func _on_body_shape_exited(body_rid: RID) -> void:
	if body_rid in tiles:
		tiles.erase(body_rid)
