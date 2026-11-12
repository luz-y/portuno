extends Node2D

var is_on_jump_pad : bool = false
@onready var left := $Left
@onready var right := $Right


func _physics_process(_delta: float) -> void:
	is_on_jump_pad = left.is_colliding() or right.is_colliding()
