extends Node2D

var cols = 10
var rows = 10
var bombs = 15
var tile = preload("res://Scenes/Tile.tscn")
var tiles

func _ready():
	randomize()
	for c in cols:
		for r in rows:
			var tile_instance = tile.instance()
			tile_instance.position = Vector2(c, r) * 32
			add_child(tile_instance)
	tiles = get_children()
	set_bomb_position()

func set_bomb_position():
	for _b in range(bombs):
		while true:
			var aux = tiles[randi()%len(tiles)]
			if aux.is_bomb == false:
				aux.set_bomb()
				break
