extends Node2D
class_name DiceAnimation

## A dice animation script that cycles through 6 sprites over 2.5 seconds
## The final sprite number (1-6) is stored and can be accessed

signal animation_finished(result: int)

@export var animation_duration: float = 2.0
@export var spin_speed: float = 10  # How fast the dice spins during animation
@export var final_scale: float = 1.5  # Scale of the final dice (50% larger)

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_timer: Timer = $AnimationTimer

var dice_sprites: Array[Texture2D] = []
var is_animating: bool = false
var final_result: int = 0

func _ready():
	# Wait a frame to make sure everything is loaded
	await get_tree().process_frame
	
	# Center the dice on screen
	var viewport_size = get_viewport().get_visible_rect().size
	position = viewport_size / 2
	
	# Set initial scale
	sprite.scale = Vector2(final_scale, final_scale)
	
	# Set up the timer
	if animation_timer:
		animation_timer.wait_time = animation_duration
		animation_timer.one_shot = true
		animation_timer.timeout.connect(_on_animation_finished)
	
	# Load dice sprites (you'll need to assign these in the editor or load them programmatically)
	_load_dice_sprites()

func _load_dice_sprites():
	"""Load the 6 dice face sprites. Replace these paths with your actual sprite paths."""
	print("Loading dice sprites...")
	
	# Method 2: Load from a folder (recommended)
	var sprite_folder = "res://sprites/"
	if DirAccess.dir_exists_absolute(sprite_folder):
		print("Sprites folder found: ", sprite_folder)
		var dir = DirAccess.open(sprite_folder)
		if dir:
			var files = dir.get_files()
			print("Found files: ", files)
			for file in files:
				if file.ends_with(".png") or file.ends_with(".jpg"):
					var texture = load(sprite_folder + file)
					if texture:
						dice_sprites.append(texture)
						print("Loaded sprite: ", file)
			dice_sprites.sort()  # Sort to ensure consistent order
	else:
		print("Sprites folder not found: ", sprite_folder)
	
	print("Total sprites loaded: ", dice_sprites.size())
	
	# Set initial sprite if we have sprites loaded
	if dice_sprites.size() >= 6:
		if sprite:
			sprite.texture = dice_sprites[0]
			print("Set initial sprite")
	else:
		print("WARNING: Not enough sprites loaded! Need 6, got ", dice_sprites.size())

func start_animation():
	"""Start the dice rolling animation"""
	if is_animating or dice_sprites.size() < 6:
		print("Cannot start animation: already animating or not enough sprites loaded")
		return
	
	is_animating = true
	animation_timer.start()
	
	# Start the spinning effect
	_start_spinning()

func _start_spinning():
	"""Create the spinning effect during animation"""
	if not is_animating:
		return
	
	# Randomly change sprite during animation
	var random_sprite = randi() % 6
	sprite.texture = dice_sprites[random_sprite]
	
	# Add some rotation for visual effect
	sprite.rotation += spin_speed * get_process_delta_time()
	
	# Schedule next frame
	await get_tree().process_frame
	if is_animating:
		_start_spinning()

func _on_animation_finished():
	"""Called when the animation timer finishes"""
	is_animating = false
	
	# Generate final result (1-6)
	final_result = randi() % 6 + 1
	
	# Set the final sprite
	sprite.texture = dice_sprites[final_result - 1]
	sprite.rotation = 0  # Reset rotation
	sprite.scale = Vector2(final_scale, final_scale)
	
	# Emit signal with the result
	animation_finished.emit(final_result)
	print("Dice animation finished! Result: ", final_result)

func get_result() -> int:
	"""Get the final dice result (1-6)"""
	return final_result

func is_animation_running() -> bool:
	"""Check if the animation is currently running"""
	return is_animating

func reset_dice():
	"""Reset the dice to its initial state"""
	is_animating = false
	animation_timer.stop()
	final_result = 0
	sprite.rotation = 0
	sprite.scale = Vector2(1.0, 1.0)
	if dice_sprites.size() > 0:
		sprite.texture = dice_sprites[0]

# Optional: Add input handling for testing
func _input(event):
	if event.is_action_pressed("ui_accept") and not is_animating:
		start_animation()
