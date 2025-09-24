extends Node

# Test script to verify game mechanics
func _ready():
	print("Testing Forest 'n' Funds game mechanics...")
	test_plant_system()
	test_tile_system()
	test_game_logic()
	print("All tests completed!")

func test_plant_system():
	print("\n=== Testing Plant System ===")
	var main = Main.new()
	
	# Test plant growth
	main.add_plant_growth(main.PlantCategory.FOOD, 25)
	assert(main.plants[main.PlantCategory.FOOD] == 25, "Plant growth should be 25")
	
	# Test plant stages
	var stage = main.get_plant_stage(25)
	assert(stage == "sapling", "25 growth should be sapling stage")
	
	stage = main.get_plant_stage(75)
	assert(stage == "full-flowered", "75 growth should be full-flowered stage")
	
	# Test negative growth (plant vanishes)
	main.add_plant_growth(main.PlantCategory.FOOD, -30)
	assert(main.plants[main.PlantCategory.FOOD] == 0, "Plant should vanish at negative growth")
	
	print("✓ Plant system tests passed")

func test_tile_system():
	print("\n=== Testing Tile System ===")
	var main = Main.new()
	
	# Test tile initialization
	assert(main.tiles.size() == 24, "Should have 24 tiles")
	
	# Count tile types
	var category_count = 0
	var investment_count = 0
	var gamble_count = 0
	
	for tile in main.tiles:
		if tile.type == main.TileType.CATEGORY:
			category_count += 1
		elif tile.type == main.TileType.INVESTMENT:
			investment_count += 1
		elif tile.type == main.TileType.GAMBLE:
			gamble_count += 1
	
	assert(category_count == 20, "Should have 20 category tiles")
	assert(investment_count == 2, "Should have 2 investment tiles")
	assert(gamble_count == 2, "Should have 2 gamble tiles")
	
	print("✓ Tile system tests passed")

func test_game_logic():
	print("\n=== Testing Game Logic ===")
	var main = Main.new()
	
	# Test win conditions
	# Set up winning scenario
	main.plants[main.PlantCategory.FOOD] = 100
	main.plants[main.PlantCategory.HEALTH] = 100
	main.plants[main.PlantCategory.EDUCATION] = 100
	main.player_money = 1000
	
	var won = main.check_win_condition()
	assert(won, "Should win with 300+ total growth and positive money")
	
	# Test lose condition
	main.player_money = -100
	var lost = main.check_lose_condition()
	assert(lost, "Should lose with negative money")
	
	print("✓ Game logic tests passed")
