extends Node2D
## Super simple dice test that doesn't require complex setup

@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var timer: Timer = $AnimationTimer

var dice_sprites: Array[Texture2D] = []
var is_animating: bool = false
var final_result: int = 0

func _ready():
	print("Simple dice test starting...")
	
	# Center the dice on screen
	var viewport_size = get_viewport().get_visible_rect().size
	sprite.position = viewport_size / 2
	
	# Increase dice size by 50%
	sprite.scale = Vector2(1.5, 1.5)
	
	# Set up timer (reduced to 2 seconds)
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.timeout.connect(_on_animation_finished)
	
	# Load sprites
	_load_sprites()
	
	# Show instructions
	label.text = "Press SPACE to roll dice!"

func _load_sprites():
	print("Loading sprites from res://sprites/")
	
	var sprite_folder = "res://sprites/"
	if DirAccess.dir_exists_absolute(sprite_folder):
		print("Found sprites folder!")
		var dir = DirAccess.open(sprite_folder)
		if dir:
			var files = dir.get_files()
			print("Files found: ", files)
			
			# Load all image files
			for file in files:
				if file.ends_with(".png") or file.ends_with(".jpg"):
					var texture = load(sprite_folder + file)
					if texture:
						dice_sprites.append(texture)
						print("Loaded: ", file)
			
			# Sort to make sure they're in order
			dice_sprites.sort()
			
			# Set initial sprite
			if dice_sprites.size() > 0:
				sprite.texture = dice_sprites[0]
				print("Set initial sprite")
			else:
				print("No sprites loaded!")
	else:
		print("Sprites folder not found!")
		label.text = "ERROR: No sprites folder found!\nCreate a 'sprites' folder with dice images"

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if not is_animating:
			start_animation()

func start_animation():
	if dice_sprites.size() < 6:
		label.text = "ERROR: Need 6 sprites!\nGot: " + str(dice_sprites.size())
		return
	
	if is_animating:
		return
	
	print("Starting dice animation...")
	is_animating = true
	label.text = "Rolling dice..."
	timer.start()
	
	# Start spinning effect
	_start_spinning()

func _start_spinning():
	if not is_animating:
		return
	
	# Change sprite randomly
	var random_sprite = randi() % dice_sprites.size()
	sprite.texture = dice_sprites[random_sprite]
	
	# Add rotation
	sprite.rotation += 0.5
	
	# Wait one frame then continue
	await get_tree().process_frame
	if is_animating:
		_start_spinning()

func _on_animation_finished():
	print("Animation finished!")
	is_animating = false
	
	# Get final result
	final_result = randi() % 6 + 1
	sprite.texture = dice_sprites[final_result - 1]
	sprite.rotation = 0
	
	label.text = "Dice rolled: " + str(final_result) + "!\nPress SPACE to roll again"
	print("Final result: ", final_result)
