extends CharacterBody2D

const COYOTE_TIME = 0.05
const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var floating_time : float = 0.0
@onready var sprite := $Sprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity. Clamp so it doesn't accelerate infinitely
	if not is_on_floor():
		if floating_time > 0.0:
			floating_time -= delta
		else:
			velocity += get_gravity() * delta
			velocity.y = minf(velocity.y, 800)
			sprite.frame = 1
	else:
		floating_time = COYOTE_TIME
		sprite.frame = 0

	# Handle jump. Ends coyote time instantly
	if Input.is_action_just_pressed("up") and floating_time > 0.0:
		velocity.y = JUMP_VELOCITY
		floating_time = 0.0
	
	# Left and Right movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
