extends Node2D

# Tile types
enum TileType {
	CATEGORY,
	INVESTMENT,
	GAMBLE
}

var tile_type: TileType
var tile_name: String = ""
var cost: int = 0
var growth: int = 0
var category: String = ""

func _ready():
	update_visual()

func set_tile_data(type: TileType, name: String, tile_cost: int, tile_growth: int = 0, tile_category: String = ""):
	tile_type = type
	tile_name = name
	cost = tile_cost
	growth = tile_growth
	category = tile_category
	update_visual()

func update_visual():
	queue_redraw()

func _draw():
	# Draw tile background
	var bg_color = get_tile_color()
	draw_rect(Rect2(-30, -30, 60, 60), bg_color)
	draw_rect(Rect2(-30, -30, 60, 60), Color.WHITE, 2)
	
	# Draw tile icon based on type
	match tile_type:
		TileType.CATEGORY:
			draw_category_icon()
		TileType.INVESTMENT:
			draw_investment_icon()
		TileType.GAMBLE:
			draw_gamble_icon()
	
	# Draw cost if applicable
	if cost > 0:
		draw_cost_text()

func draw_category_icon():
	# Draw a simple plant icon
	var color = get_category_color()
	draw_circle(Vector2(0, -10), 8, color)
	draw_line(Vector2(0, -2), Vector2(0, 15), color, 3)
	draw_line(Vector2(-5, 5), Vector2(5, 5), color, 2)

func draw_investment_icon():
	# Draw money/coin icon
	draw_circle(Vector2(0, 0), 12, Color.GOLD)
	draw_circle(Vector2(0, 0), 12, Color.ORANGE, 2)
	# Draw ₹ symbol
	draw_line(Vector2(-3, -5), Vector2(3, -5), Color.WHITE, 2)
	draw_line(Vector2(-3, -5), Vector2(-3, 5), Color.WHITE, 2)

func draw_gamble_icon():
	# Draw dice icon
	draw_rect(Rect2(-8, -8, 16, 16), Color.WHITE)
	draw_rect(Rect2(-8, -8, 16, 16), Color.BLACK, 2)
	# Draw dots
	draw_circle(Vector2(-3, -3), 1, Color.BLACK)
	draw_circle(Vector2(3, 3), 1, Color.BLACK)
	draw_circle(Vector2(0, 0), 1, Color.BLACK)

func draw_cost_text():
	# Draw cost in corner
	var font = ThemeDB.fallback_font
	var font_size = 12
	var cost_text = "₹" + str(cost)
	var text_size = font.get_string_size(cost_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
	draw_string(font, Vector2(25, 25), cost_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, Color.WHITE)

func get_tile_color() -> Color:
	match tile_type:
		TileType.CATEGORY:
			return get_category_color()
		TileType.INVESTMENT:
			return Color.GOLD
		TileType.GAMBLE:
			return Color.ORANGE
		_:
			return Color.GRAY

func get_category_color() -> Color:
	match category:
		"Food":
			return Color.GREEN
		"Health":
			return Color.RED
		"Education":
			return Color.BLUE
		"Travel":
			return Color.CYAN
		"Luxury":
			return Color.PURPLE
		_:
			return Color.WHITE
