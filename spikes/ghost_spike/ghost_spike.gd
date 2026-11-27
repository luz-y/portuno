extends Node2D

const RANGE = 32.0

var _player : Node2D


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(_player):
		_player = get_tree().get_first_node_in_group(&"player")
	
	if not is_instance_valid(_player):
		return
	
	if global_position.distance_squared_to(_player.global_position) > RANGE ** 2:
		global_position = global_position.lerp(_player.global_position, 0.1)
		return
	
	print("Jumpscare")
	queue_free()
