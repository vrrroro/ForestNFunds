extends Node2D

var tiles = []
var player_position = 0
var tile_sprites = []

func _ready():
	create_board()

func create_board():
	# Create 24 tiles in a circular pattern
	var radius = 200
	var center = Vector2(400, 300)
	
	for i in range(24):
		var angle = (i * 2 * PI) / 24
		var pos = center + Vector2(cos(angle), sin(angle)) * radius
		
		# Create tile sprite
		var tile_sprite = Node2D.new()
		tile_sprite.position = pos
		tile_sprite.add_script(load("res://TileSprite.gd"))
		add_child(tile_sprite)
		tile_sprites.append(tile_sprite)
		
		# Add tile number
		var label = Label.new()
		label.text = str(i + 1)
		label.position = pos + Vector2(-10, -10)
		add_child(label)

func update_tiles(tile_data):
	for i in range(min(tile_data.size(), tile_sprites.size())):
		var tile = tile_data[i]
		var sprite = tile_sprites[i]
		
		if sprite.has_method("set_tile_data"):
			var type = 0  # CATEGORY
			if tile.type == 1:  # INVESTMENT
				type = 1
			elif tile.type == 2:  # GAMBLE
				type = 2
			
			sprite.set_tile_data(type, tile.name, tile.cost, tile.growth, tile.category)

func update_player_position(pos):
	player_position = pos
	queue_redraw()

func _draw():
	# Draw player position indicator
	if tile_sprites.size() > player_position:
		var tile_pos = tile_sprites[player_position].position
		draw_circle(tile_pos, 15, Color.YELLOW)
		draw_circle(tile_pos, 15, Color.BLACK, 3)
