extends Node2D
## Simple test controller to make the dice roll automatically

@onready var dice: DiceAnimation = $DiceAnimation
@onready var label: Label = $Label

func _ready():
	# Wait a frame to make sure everything is loaded
	await get_tree().process_frame
	
	# Check if dice node exists
	if dice == null:
		print("ERROR: Dice node not found!")
		label.text = "ERROR: Dice node not found!"
		return
	
	# Connect to the dice animation signal
	dice.animation_finished.connect(_on_dice_finished)
	
	# Start the dice animation after 1 second
	await get_tree().create_timer(1.0).timeout
	label.text = "Rolling dice..."
	dice.start_animation()

func _on_dice_finished(result: int):
	label.text = "Dice rolled: " + str(result) + "!\nPress SPACE to roll again"

func _input(event):
	# Press space to roll again
	if event.is_action_pressed("ui_accept"):
		if not dice.is_animation_running():
			label.text = "Rolling dice..."
			dice.start_animation()
