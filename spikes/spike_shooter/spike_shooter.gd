extends Node2D

const PROJECTILE = preload("uid://yhvv3x7shrv1")

@onready var muzzle := $Muzzle


func _ready() -> void:
	GlobalTimer.timeout.connect(_shoot)


func _shoot() -> void:
	var spike : Node2D = PROJECTILE.instantiate()
	spike.global_transform = muzzle.global_transform
	get_tree().current_scene.add_child(spike)
