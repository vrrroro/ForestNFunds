extends Control

# UI References
@onready var money_label = $VBoxContainer/HBoxContainer/MoneyLabel
@onready var dice_rolls_label = $VBoxContainer/HBoxContainer/DiceRollsLabel
@onready var roll_button = $VBoxContainer/RollButton
@onready var plants_container = $VBoxContainer/PlantsContainer
@onready var modal = $Modal
@onready var modal_title = $Modal/VBoxContainer/Title
@onready var modal_text = $Modal/VBoxContainer/Text
@onready var modal_spend_button = $Modal/VBoxContainer/SpendButton
@onready var modal_skip_button = $Modal/VBoxContainer/SkipButton
@onready var modal_close_button = $Modal/VBoxContainer/CloseButton

var main_game: Node2D
var current_tile = null

func _ready():
	main_game = get_parent()
	modal.visible = false
	setup_ui_styling()
	update_ui()

func setup_ui_styling():
	# Style the modal
	modal.modulate = Color(1, 1, 1, 0.9)
	
	# Style buttons
	roll_button.modulate = Color(0.8, 1.0, 0.8)
	modal_spend_button.modulate = Color(0.8, 1.0, 0.8)
	modal_skip_button.modulate = Color(1.0, 0.8, 0.8)
	modal_close_button.modulate = Color(0.8, 0.8, 1.0)

func update_ui():
	money_label.text = "Money: ₹" + str(main_game.player_money)
	dice_rolls_label.text = "Rolls: " + str(main_game.dice_rolls_remaining)
	update_plants_display()

func update_plants_display():
	# Clear existing plant labels
	for child in plants_container.get_children():
		child.queue_free()
	
	# Add plant labels
	for category in main_game.PlantCategory.values():
		var growth = main_game.plants[category]
		var stage = main_game.get_plant_stage(growth)
		var label = Label.new()
		label.text = main_game.plant_categories[category].name + ": " + str(growth) + " (" + stage + ")"
		plants_container.add_child(label)

func show_tile_modal(tile):
	current_tile = tile
	modal_title.text = tile.name
	modal_text.text = tile.modal
	
	# Show appropriate buttons based on tile type
	modal_spend_button.visible = true
	modal_skip_button.visible = true
	modal_close_button.visible = false
	
	if tile.type == 0:  # CATEGORY
		modal_spend_button.text = "Spend ₹" + str(tile.cost) + " (Growth +" + str(tile.growth) + ")"
	elif tile.type == 1:  # INVESTMENT
		modal_spend_button.text = "Invest ₹" + str(tile.cost)
	elif tile.type == 2:  # GAMBLE
		modal_spend_button.text = "Gamble ₹" + str(tile.cost)
	
	modal.visible = true

func _on_roll_button_pressed():
	main_game.roll_dice()
	update_ui()

func _on_spend_button_pressed():
	if current_tile == null:
		return
	
	if current_tile.type == 0:  # CATEGORY
		if main_game.spend_money(current_tile.cost):
			main_game.add_plant_growth(current_tile.category, current_tile.growth)
			main_game.skip_count = 0  # Reset skip count on spend
		else:
			print("Not enough money!")
	
	elif current_tile.type == 1:  # INVESTMENT
		if main_game.spend_money(current_tile.cost):
			main_game.investments.append(current_tile.cost)
			main_game.skip_count = 0  # Reset skip count on spend
	
	elif current_tile.type == 2:  # GAMBLE
		if main_game.spend_money(current_tile.cost):
			var won = randf() < 0.5  # 50% chance
			if won:
				main_game.player_money += 200
				# Add +8 to random plant
				var random_category = main_game.PlantCategory.values()[randi() % main_game.PlantCategory.size()]
				main_game.add_plant_growth(random_category, 8)
				print("You won! +₹200 and +8 growth to random plant")
			else:
				# Subtract -6 from random plant
				var random_category = main_game.PlantCategory.values()[randi() % main_game.PlantCategory.size()]
				main_game.add_plant_growth(random_category, -6)
				print("You lost! -6 growth from random plant")
			main_game.skip_count = 0  # Reset skip count on spend
	
	modal.visible = false
	update_ui()
	
	# Check for game end
	if main_game.dice_rolls_remaining <= 0:
		main_game.end_game()

func _on_skip_button_pressed():
	main_game.skip_count += 1
	modal.visible = false
	
	# Check for skip penalty
	if main_game.skip_count >= 3:
		# Random plant loses 5 growth
		var random_category = main_game.PlantCategory.values()[randi() % main_game.PlantCategory.size()]
		main_game.add_plant_growth(random_category, -5)
		main_game.skip_count = 0  # Reset skip count
		print("Skip penalty! Random plant lost 5 growth")
	
	update_ui()
	
	# Check for game end
	if main_game.dice_rolls_remaining <= 0:
		main_game.end_game()

func _on_close_button_pressed():
	modal.visible = false
