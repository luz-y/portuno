extends Area2D


func _on_body_shape_entered(body_rid: RID, body: Node2D) -> void:
	if body is TileMapLayer:
		var coords = body.get_coords_for_body_rid(body_rid)
		var data = body.get_cell_tile_data(coords)
		print(coords, data.get_custom_data("spike_type"))


func _on_area_entered() -> void:
	print("Dead")
