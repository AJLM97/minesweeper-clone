extends Node2D

var is_cover = true
var flagged = false
var is_bomb = false

func set_bomb():
	is_bomb = true

func is_over():
	var bombs_flagged = 0
	var tiles_uncover = 0
	for tile in get_parent().tiles:
		if tile.is_cover == false and tile.is_bomb == false:
			tiles_uncover += 1
		if tile.flagged == true and tile.is_bomb == true:
			bombs_flagged += 1
	if (bombs_flagged + tiles_uncover) == 100:
		Global.game_clear()

func uncover():
	if flagged == false and is_cover == true:
		is_cover = false
		if is_bomb == true:
			end_game()
		else:
			var count_surrounds = 0
			for tile in get_surrounds():
				if tile.is_bomb == true:
					count_surrounds += 1
			if count_surrounds > 0:
				change_sprite("res://Assets/Game Objects/Tile" + str(count_surrounds) + ".png")
			else:
				change_sprite("res://Assets/Game Objects/TileEmpty.png")
				for tile in get_surrounds():
					if tile.is_cover == true:
						tile.uncover()

func get_surrounds():
	var surrounds = []
	var offsets = [
		(Vector2.UP + Vector2.LEFT) * 32,
		Vector2.UP * 32,
		(Vector2.UP + Vector2.RIGHT) * 32,
		Vector2.LEFT * 32,
		Vector2.RIGHT * 32,
		(Vector2.DOWN + Vector2.LEFT) * 32,
		Vector2.DOWN * 32,
		(Vector2.DOWN + Vector2.RIGHT) * 32,
	]
	
	for offset in offsets:
		for tile in get_parent().tiles:
			if tile.position == position + offset:
				surrounds.append(tile)
	return surrounds

func toggle_flag():
	if is_cover == true:
		$Tick.play()
		if flagged == true:
			flagged = false
			change_sprite("res://Assets/Game Objects/TileUnknown.png")
			Global.add_point(-1)
		else:
			flagged = true
			change_sprite("res://Assets/Game Objects/TileFlag.png")
			Global.add_point(1)

func change_sprite(name: String):
	var texture = ResourceLoader.load(name)
	if texture != null:
		$Sprite.texture = texture

func end_game():
	$Boom.play()
	for tile in get_parent().tiles:
		if tile.flagged == true and tile.is_bomb == false:
			tile.change_sprite("res://Assets/Game Objects/TileFalse.png")
		if tile.flagged == false and tile.is_bomb == true:
			tile.change_sprite("res://Assets/Game Objects/TileMine.png")
	change_sprite("res://Assets/Game Objects/TileExploded.png")
	Global.game_over()

func _on_Control_gui_input(event):
	if Global.is_alive == true:
		if event is InputEventMouseButton:
			if event.is_action_pressed("RightClick"):
					toggle_flag()
					if flagged == true and is_cover == true and is_bomb == true:
						is_over()
			if event.is_action_pressed("LeftClick"):
				uncover()
				if flagged == false and is_cover == false and is_bomb == false:
					Global.wow_face()
					is_over()
