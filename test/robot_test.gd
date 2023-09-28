# GdUnit generated TestSuite
class_name RobotTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://robot.gd'


func test_can_cross_3_gap() -> void:
	var runner = scene_runner("res://test/test_room.tscn")
	var robot = runner.invoke("find_child", "Robot")
	var zone = runner.invoke("find_child", "JumpPassZone")
	await await_millis(1000)
	robot.set_movement(Vector2(0,1))
	robot.jump()
	await assert_signal(zone).wait_until(3000).is_emitted("body_entered", [robot])


func test_cannot_cross_4_gap() -> void:
	var runner = scene_runner("res://test/test_room.tscn")
	var robot = runner.invoke("find_child", "Robot")
	var zone = runner.invoke("find_child", "JumpFailZone")
	await await_millis(1000)
	robot.set_movement(Vector2(1,0))
	robot.jump()
	await assert_signal(zone).wait_until(3000).is_not_emitted("body_entered", [robot])


func test_can_climb_2_blocks() -> void:
	var runner = scene_runner("res://test/test_room.tscn")
	var robot = runner.invoke("find_child", "Robot")
	var zone = runner.invoke("find_child", "HiJumpPassZone")
	await await_millis(1000)
	robot.set_movement(Vector2(0,-1))
	robot.jump()
	await assert_signal(zone).wait_until(3000).is_emitted("body_entered", [robot])


func test_cannot_climb_3_blocks() -> void:
	var runner = scene_runner("res://test/test_room.tscn")
	var robot = runner.invoke("find_child", "Robot")
	var zone = runner.invoke("find_child", "HiJumpFailZone")
	await await_millis(1000)
	robot.set_movement(Vector2(-1,0))
	robot.jump()
	await assert_signal(zone).wait_until(3000).is_not_emitted("body_entered", [robot])

