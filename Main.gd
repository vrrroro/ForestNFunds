extends Node2D

# Game state
var player_money = 5000
var dice_rolls_remaining = 24
var player_position = 0
var skip_count = 0
var plants = {}
var investments = []
var game_ended = false

# Plant categories
enum PlantCategory {
	FOOD,
	HEALTH,
	EDUCATION,
	TRAVEL,
	LUXURY
}

# Tile types
enum TileType {
	CATEGORY,
	INVESTMENT,
	GAMBLE
}

# Plant data
var plant_categories = {
	PlantCategory.FOOD: {"name": "Food", "growth": 0},
	PlantCategory.HEALTH: {"name": "Health", "growth": 0},
	PlantCategory.EDUCATION: {"name": "Education", "growth": 0},
	PlantCategory.TRAVEL: {"name": "Travel", "growth": 0},
	PlantCategory.LUXURY: {"name": "Luxury", "growth": 0}
}

# Tile definitions
var tiles = []

func _ready():
	initialize_plants()
	initialize_tiles()
	setup_ui()

func initialize_plants():
	for category in PlantCategory.values():
		plants[category] = 0

func initialize_tiles():
	# 20 Category tiles (4 per category)
	var category_tiles = [
		# Food tiles
		{"type": TileType.CATEGORY, "category": "Food", "name": "Farm Fresh Groceries", "cost": 200, "growth": 12, "modal": "Stocking up on fresh produce strengthens your garden roots."},
		{"type": TileType.CATEGORY, "category": "Food", "name": "Street Snacks", "cost": 120, "growth": 7, "modal": "Quick bites add small nourishment to your plant."},
		{"type": TileType.CATEGORY, "category": "Food", "name": "Organic Feast", "cost": 300, "growth": 18, "modal": "Organic choices give a bigger growth boost."},
		{"type": TileType.CATEGORY, "category": "Food", "name": "Family Dinner Night", "cost": 180, "growth": 10, "modal": "Sharing meals fosters stronger growth."},
		
		# Health tiles
		{"type": TileType.CATEGORY, "category": "Health", "name": "Doctor Visit", "cost": 250, "growth": 15, "modal": "Health checkups give steady plant growth."},
		{"type": TileType.CATEGORY, "category": "Health", "name": "Gym Subscription", "cost": 200, "growth": 12, "modal": "Exercise nourishes your garden with steady growth."},
		{"type": TileType.CATEGORY, "category": "Health", "name": "Emergency Medicine", "cost": 300, "growth": 20, "modal": "Unexpected health costs but boosts resilience."},
		{"type": TileType.CATEGORY, "category": "Health", "name": "Yoga Retreat", "cost": 180, "growth": 10, "modal": "Peaceful routines improve long-term growth."},
		
		# Education tiles
		{"type": TileType.CATEGORY, "category": "Education", "name": "Book Purchase", "cost": 200, "growth": 12, "modal": "Knowledge feeds your garden with small but steady growth."},
		{"type": TileType.CATEGORY, "category": "Education", "name": "Online Course", "cost": 250, "growth": 15, "modal": "Learning new skills boosts your growth further."},
		{"type": TileType.CATEGORY, "category": "Education", "name": "College Tuition", "cost": 350, "growth": 22, "modal": "Big investment for big plant growth."},
		{"type": TileType.CATEGORY, "category": "Education", "name": "Workshop Event", "cost": 180, "growth": 10, "modal": "Small events still add useful growth."},
		
		# Travel tiles
		{"type": TileType.CATEGORY, "category": "Travel", "name": "Weekend Getaway", "cost": 220, "growth": 12, "modal": "Short trip, small growth refresh."},
		{"type": TileType.CATEGORY, "category": "Travel", "name": "Long Vacation", "cost": 350, "growth": 20, "modal": "Expensive but gives a big boost."},
		{"type": TileType.CATEGORY, "category": "Travel", "name": "Train Journey", "cost": 180, "growth": 9, "modal": "Affordable trip, modest growth."},
		{"type": TileType.CATEGORY, "category": "Travel", "name": "Cultural Tour", "cost": 250, "growth": 14, "modal": "Travel expands horizons, garden thrives."},
		
		# Luxury tiles
		{"type": TileType.CATEGORY, "category": "Luxury", "name": "Designer Clothes", "cost": 280, "growth": 12, "modal": "Expensive indulgence, small growth reward."},
		{"type": TileType.CATEGORY, "category": "Luxury", "name": "Fancy Car Ride", "cost": 320, "growth": 14, "modal": "Flashy spend grows your luxury plant."},
		{"type": TileType.CATEGORY, "category": "Luxury", "name": "Fine Dining", "cost": 220, "growth": 10, "modal": "Expensive meal, moderate growth."},
		{"type": TileType.CATEGORY, "category": "Luxury", "name": "Gadget Upgrade", "cost": 300, "growth": 15, "modal": "Technology spend fuels your luxury plant."}
	]
	
	# 4 Special tiles
	var special_tiles = [
		{"type": TileType.INVESTMENT, "name": "Investment Bank", "cost": 200, "modal": "Deposit ₹200. Returns 25% profit at game end, bonus travel growth."},
		{"type": TileType.INVESTMENT, "name": "Stock Market", "cost": 200, "modal": "Deposit ₹200. Returns 25% profit at game end, bonus travel growth."},
		{"type": TileType.GAMBLE, "name": "Casino Night", "cost": 100, "modal": "Gamble ₹100. Win big or lose growth."},
		{"type": TileType.GAMBLE, "name": "Lottery Stall", "cost": 100, "modal": "Gamble ₹100. Win big or lose growth."}
	]
	
	# Combine and shuffle tiles
	tiles = category_tiles + special_tiles
	tiles.shuffle()

func setup_ui():
	# Connect to UI signals
	var game_ui = $GameUI
	game_ui.roll_button.pressed.connect(_on_roll_button_pressed)
	game_ui.modal_spend_button.pressed.connect(_on_modal_spend_pressed)
	game_ui.modal_skip_button.pressed.connect(_on_modal_skip_pressed)
	game_ui.modal_close_button.pressed.connect(_on_modal_close_pressed)
	
	# Setup visual game board
	var game_board = $GameBoard
	game_board.update_tiles(tiles)
	
	# Setup plant sprites
	setup_plant_sprites()

func roll_dice():
	if dice_rolls_remaining <= 0 or game_ended:
		return
	
	var roll = randi() % 6 + 1  # 1-6 dice roll
	dice_rolls_remaining -= 1
	player_position = (player_position + roll) % 24
	
	# Update visual board
	var game_board = $GameBoard
	game_board.update_player_position(player_position)
	
	# Handle tile landing
	land_on_tile()

func land_on_tile():
	var tile = tiles[player_position]
	show_tile_modal(tile)

func show_tile_modal(tile):
	var game_ui = $GameUI
	game_ui.show_tile_modal(tile)

func spend_money(amount):
	if player_money >= amount:
		player_money -= amount
		return true
	return false

func add_plant_growth(category, amount):
	plants[category] += amount
	# Ensure growth doesn't go below 0
	if plants[category] < 0:
		plants[category] = 0
	
	# Update visual representation
	update_plant_visuals()

func get_plant_stage(growth):
	if growth >= 75:
		return "full-flowered"
	elif growth >= 50:
		return "plant"
	elif growth >= 25:
		return "sapling"
	else:
		return "seed"

func check_win_condition():
	var total_growth = 0
	var full_flowered_count = 0
	
	for category in PlantCategory.values():
		total_growth += plants[category]
		if plants[category] >= 75:
			full_flowered_count += 1
	
	# Win if: (a) total growth ≥ 300, or (b) at least 2 plants full-flowered (≥75), and money ≥ 0
	return (total_growth >= 300 or full_flowered_count >= 2) and player_money >= 0

func check_lose_condition():
	return player_money < 0

func end_game():
	game_ended = true
	var won = check_win_condition()
	var lost = check_lose_condition()
	
	if lost:
		print("Game Over! You went bankrupt!")
	elif won:
		print("Congratulations! You won!")
	else:
		print("Game Over! You didn't meet the win conditions.")
	
	# Process investments
	for investment in investments:
		player_money += investment * 1.25  # 25% return
		add_plant_growth(PlantCategory.TRAVEL, 6)

# Signal handlers
func _on_roll_button_pressed():
	roll_dice()
	var game_ui = $GameUI
	game_ui.update_ui()

func _on_modal_spend_pressed():
	var game_ui = $GameUI
	game_ui._on_spend_button_pressed()

func _on_modal_skip_pressed():
	var game_ui = $GameUI
	game_ui._on_skip_button_pressed()

func _on_modal_close_pressed():
	var game_ui = $GameUI
	game_ui._on_close_button_pressed()

func setup_plant_sprites():
	# Create plant sprites for each category
	var plant_container = $PlantContainer
	if not plant_container:
		plant_container = Node2D.new()
		plant_container.name = "PlantContainer"
		add_child(plant_container)
	
	# Position plants in a row
	var start_x = 50
	var spacing = 100
	
	for i in range(PlantCategory.size()):
		var plant_sprite = Node2D.new()
		plant_sprite.position = Vector2(start_x + i * spacing, 100)
		plant_sprite.add_script(load("res://PlantSprite.gd"))
		plant_container.add_child(plant_sprite)
		
		# Set initial plant data
		var category_name = plant_categories[PlantCategory.values()[i]].name
		plant_sprite.set_growth(0, category_name)

func update_plant_visuals():
	var plant_container = $PlantContainer
	if plant_container:
		var children = plant_container.get_children()
		for i in range(min(children.size(), PlantCategory.size())):
			var plant_sprite = children[i]
			var category = PlantCategory.values()[i]
			var category_name = plant_categories[category].name
			plant_sprite.set_growth(plants[category], category_name)
