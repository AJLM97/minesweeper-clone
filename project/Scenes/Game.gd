extends Node2D

var time = 0

func _ready():
	var _points_changed = Global.connect("points_changed", self, "change_points")
	var _game_over_signal = Global.connect("game_over_signal", self, "game_over")
	var _game_clear_signal = Global.connect("game_clear_signal", self, "game_clear")
	var _wow_face_signal = Global.connect("wow_face_signal", self, "wow_face")

func change_points(actual_points: int):
	$Flags.change_counter(actual_points)

func wow_face():
	$Wow.start()
	$Face.change_face(1)

func game_over():
	$Timer.stop()
	$Face.change_face(2)

func game_clear():
	$Timer.stop()
	$Face.change_face(3)

func _on_Timer_timeout():
	if time < 999:
		time += 1
		$Time.change_counter(time)
	else:
		$Timer.stop()

func _on_Wow_timeout():
	if Global.is_alive == true:
		$Face.change_face(0)
