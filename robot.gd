class_name Robot
extends CharacterBody3D

enum {IDLE, RUNNING, JUMPING, FALLING}

@export var move_speed := 5
@export var jump_speed := 8

var state := IDLE:
	set(value):
		if state == value:
			return
		state = value
		match value:
			IDLE:
				animator.play("Idle")
			RUNNING:
				animator.play("Run")
			JUMPING:
				animator.play("Jump")
			FALLING:
				animator.play("Fall")

@onready var model = $Model
@onready var animator = $Model/AnimationPlayer


func _physics_process(delta):
	# apply gravity and move
	velocity += Vector3.DOWN * delta * 10
	move_and_slide()

	# update state
	if velocity.y > 0:
		state = JUMPING
	elif velocity.y < 0:
		state = FALLING
	elif velocity == Vector3.ZERO:
		state = IDLE
	else:
		state = RUNNING


##  the character moves in the x-z plane ignoring the y component of direction,
##  the sprite rotates but the root node does not to avoid changing the camera direction
func set_movement(input: Vector2) -> void:
	if input == Vector2.ZERO:
		velocity.x = 0
		velocity.z = 0
		return
	velocity.x = input.x * move_speed
	velocity.z = input.y * move_speed
	# look in direction of movement
	var target : Vector3 = position + Vector3(input.x, 0, input.y)
	model.look_at(target, Vector3.UP, true)
	model.rotation.x = 0
	model.rotation.z = 0


func jump() -> void:
	if is_on_floor():
		velocity.y = jump_speed
