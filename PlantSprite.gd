extends Node2D

# Plant growth stages
enum GrowthStage {
	SEED,
	SAPLING,
	PLANT,
	FULL_FLOWERED
}

var growth_stage: GrowthStage = GrowthStage.SEED
var growth_amount: int = 0
var plant_category: String = ""

func _ready():
	update_visual()

func set_growth(amount: int, category: String):
	growth_amount = amount
	plant_category = category
	update_growth_stage()
	update_visual()

func update_growth_stage():
	if growth_amount >= 75:
		growth_stage = GrowthStage.FULL_FLOWERED
	elif growth_amount >= 50:
		growth_stage = GrowthStage.PLANT
	elif growth_amount >= 25:
		growth_stage = GrowthStage.SAPLING
	else:
		growth_stage = GrowthStage.SEED

func update_visual():
	queue_redraw()

func _draw():
	# Draw plant based on growth stage and category
	var color = get_category_color()
	var size = get_stage_size()
	
	match growth_stage:
		GrowthStage.SEED:
			draw_circle(Vector2.ZERO, size, color)
		GrowthStage.SAPLING:
			draw_circle(Vector2.ZERO, size, color)
			draw_line(Vector2(0, -size), Vector2(0, size * 2), color, 3)
		GrowthStage.PLANT:
			draw_circle(Vector2.ZERO, size, color)
			draw_line(Vector2(0, -size), Vector2(0, size * 2), color, 4)
			# Draw leaves
			draw_line(Vector2(-size/2, -size/2), Vector2(size/2, -size/2), color, 2)
			draw_line(Vector2(-size/2, size/2), Vector2(size/2, size/2), color, 2)
		GrowthStage.FULL_FLOWERED:
			draw_circle(Vector2.ZERO, size, color)
			draw_line(Vector2(0, -size), Vector2(0, size * 2), color, 5)
			# Draw leaves
			draw_line(Vector2(-size/2, -size/2), Vector2(size/2, -size/2), color, 3)
			draw_line(Vector2(-size/2, size/2), Vector2(size/2, size/2), color, 3)
			# Draw flowers
			draw_circle(Vector2(-size/2, -size/2), size/4, Color.YELLOW)
			draw_circle(Vector2(size/2, -size/2), size/4, Color.YELLOW)
			draw_circle(Vector2(-size/2, size/2), size/4, Color.YELLOW)
			draw_circle(Vector2(size/2, size/2), size/4, Color.YELLOW)

func get_category_color() -> Color:
	match plant_category:
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

func get_stage_size() -> float:
	match growth_stage:
		GrowthStage.SEED:
			return 8.0
		GrowthStage.SAPLING:
			return 12.0
		GrowthStage.PLANT:
			return 16.0
		GrowthStage.FULL_FLOWERED:
			return 20.0
		_:
			return 8.0
