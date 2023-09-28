extends Node2D

func change_counter(points):
	var u = 0
	var d = 0
	var c = 0
	if points < 10:
		u = points + 1
	elif points < 100:
		u = (points % 10) + 1
		points /= 10
		d = (points % 10) + 1
	elif points < 1000:
		u = (points % 10) + 1
		points /= 10
		d = (points % 10) + 1
		points /= 10
		c = (points % 10) + 1
	else:
		u = 9
		d = 9
		c = 9
	$U.frame = u
	$D.frame = d
	$C.frame = c
