extends Node


var puppet : Robot


func _ready():
	puppet = get_parent()


func _physics_process(delta):
	if not is_instance_valid(puppet):
		return
	var move_input = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	puppet.set_movement(move_input)

	if Input.is_action_just_pressed("ui_select"):
		puppet.jump()
