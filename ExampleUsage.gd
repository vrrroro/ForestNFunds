extends Node2D
## Example script showing how to use the DiceAnimation

@onready var dice: DiceAnimation = $DiceAnimation

func _ready():
	# Connect to the animation finished signal
	dice.animation_finished.connect(_on_dice_animation_finished)
	
	# Start the animation after a short delay
	await get_tree().create_timer(1.0).timeout
	dice.start_animation()

func _on_dice_animation_finished(result: int):
	print("Dice rolled: ", result)
	
	# You can add your game logic here based on the result
	match result:
		1:
			print("Snake eyes!")
		2, 3, 4, 5:
			print("Decent roll!")
		6:
			print("Lucky six!")

func _input(event):
	# Press space to roll again
	if event.is_action_pressed("ui_accept"):
		if not dice.is_animation_running():
			dice.start_animation()
