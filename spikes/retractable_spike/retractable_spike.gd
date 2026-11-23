extends Area2D

@export var is_retracted : bool = false
var touched_player : bool = false
@onready var sprite := $Sprite2D

# Saved me from headache that caused by some computer number quirks.
func _ready() -> void:
	GlobalTimer.timeout.connect(_change_state)
	
	if is_retracted:
		sprite.position = Vector2(0, 32)


func _physics_process(_delta: float) -> void:
	if is_retracted or not touched_player:
		return
	
	EventBus.player_died.emit()


func _process(delta: float) -> void:
	var target_pos := Vector2(0, 32) if is_retracted else Vector2.ZERO
	
	sprite.position = sprite.position.move_toward(target_pos, delta * 512)


func _on_area_entered() -> void:
	touched_player = true


func _on_area_exited() -> void:
	touched_player = false


func _change_state() -> void:
	is_retracted = not is_retracted
