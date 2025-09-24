extends Node2D

# Tile types
enum TileType {
	CATEGORY,
	INVESTMENT,
	GAMBLE
}

var tile_type: int
var tile_name: String = ""
var cost: int = 0
var growth: int = 0
var category: String = ""
var sprite: Sprite2D

func _ready():
	# Create sprite node
	sprite = Sprite2D.new()
	add_child(sprite)
	update_visual()

func set_tile_data(type: int, name: String, tile_cost: int, tile_growth: int = 0, tile_category: String = ""):
	tile_type = type
	tile_name = name
	cost = tile_cost
	growth = tile_growth
	category = tile_category
	update_visual()

func update_visual():
	if sprite:
		var texture_path = get_tile_sprite_path()
		if texture_path != "":
			var texture = load(texture_path)
			if texture:
				sprite.texture = texture
				# Scale the sprite to appropriate size
				sprite.scale = Vector2(0.4, 0.4)  # Adjust scale as needed

func get_tile_sprite_path() -> String:
	var sprite_data = load("res://TileSprites.gd").new()
	return sprite_data.get_tile_sprite_path(tile_name)
