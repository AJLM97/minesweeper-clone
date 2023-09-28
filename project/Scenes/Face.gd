extends Node2D

func change_face(face: int):
	$Face.frame = face

func _on_Control_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("LeftClick"):
			Global.restart()
