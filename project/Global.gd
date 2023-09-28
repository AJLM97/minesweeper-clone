extends Node

signal points_changed(new_points)
signal game_over_signal()
signal game_clear_signal()
signal wow_face_signal()

var is_alive = true
var actual_points = 0
var tiles_clear = 0

func add_tile():
	tiles_clear += 1
	emit_signal("points_changed", actual_points+tiles_clear)

func add_point(points: int):
	actual_points += points
	emit_signal("points_changed", actual_points+tiles_clear)

func game_over():
	is_alive = false
	emit_signal("game_over_signal")

func game_clear():
	is_alive = false
	emit_signal("game_clear_signal")

func wow_face():
	emit_signal("wow_face_signal")

func restart():
	is_alive = true
	actual_points = 0
	var _value = get_tree().reload_current_scene()
