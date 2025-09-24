HEAD
# ForestNFunds
A strategic board game where every financial decision you make nurtures growth. Invest wisely, trade smart, and watch your forest flourish—or wither—based on your money moves. The goal: balance wealth and nature to become the ultimate eco-tycoon.

# Dice Animation for Godot

A complete dice animation system for Godot 4.x that cycles through 6 sprites over 2.5 seconds and stores the final result.

## Features

- **2.5-second animation duration** (configurable)
- **6 sprite support** for different dice faces
- **Random final result** (1-6) stored and accessible
- **Visual spinning effect** during animation
- **Signal-based communication** for easy integration
- **Fully configurable** through exported variables

## Files Included

- `DiceAnimation.gd` - Main dice animation script
- `DiceScene.tscn` - Basic scene with the dice node
- `ExampleUsage.gd` - Example of how to use the dice animation
- `project.godot` - Godot project configuration

## Setup Instructions

### 1. Prepare Your Sprites

Create a `sprites` folder in your project and add 6 dice face images:
- `dice_1.png` (or `.jpg`)
- `dice_2.png`
- `dice_3.png`
- `dice_4.png`
- `dice_5.png`
- `dice_6.png`

### 2. Configure the Script

The script will automatically load sprites from the `res://sprites/` folder. You can also modify the `_load_dice_sprites()` function to load from different paths.

### 3. Usage

```gdscript
# Get reference to the dice node
@onready var dice: DiceAnimation = $DiceAnimation

# Connect to the finished signal
dice.animation_finished.connect(_on_dice_finished)

# Start the animation
dice.start_animation()

# Handle the result
func _on_dice_finished(result: int):
	print("Dice rolled: ", result)
```

## Configuration Options

The script has several exported variables you can adjust in the editor:

- `animation_duration` (float): How long the animation lasts (default: 2.5)
- `spin_speed` (float): How fast the dice spins (default: 20.0)
- `final_scale` (float): Scale of the final dice (default: 1.0)

## API Reference

### Methods

- `start_animation()` - Start the dice rolling animation
- `get_result() -> int` - Get the final dice result (1-6)
- `is_animation_running() -> bool` - Check if animation is running
- `reset_dice()` - Reset dice to initial state

### Signals

- `animation_finished(result: int)` - Emitted when animation completes with the result

## How to Import into Another Godot Project

### Method 1: Copy Files (Recommended)

1. **Copy the script file:**
   - Copy `DiceAnimation.gd` to your project's scripts folder
   - Or place it in a subfolder like `res://scripts/dice/`

2. **Copy the scene file:**
   - Copy `DiceScene.tscn` to your project
   - Or create a new scene and add the script to a Node2D

3. **Prepare your sprites:**
   - Create a `sprites` folder in your project
   - Add your 6 dice face images with names like `dice_1.png`, `dice_2.png`, etc.

4. **Use in your project:**
   ```gdscript
   # Load the scene
   var dice_scene = preload("res://DiceScene.tscn")
   var dice_instance = dice_scene.instantiate()
   add_child(dice_instance)
   
   # Or add the script to an existing node
   var dice_node = Node2D.new()
   dice_node.set_script(load("res://DiceAnimation.gd"))
   add_child(dice_node)
   ```

### Method 2: Create as a Plugin

1. **Create plugin structure:**
   ```
   addons/
   └── dice_animation/
       ├── plugin.cfg
       ├── DiceAnimation.gd
       └── DiceScene.tscn
   ```

2. **Create `plugin.cfg`:**
   ```ini
   [plugin]
   name="Dice Animation"
   description="A dice animation system"
   author="Your Name"
   version="1.0"
   script="DiceAnimation.gd"
   ```

3. **Enable the plugin** in Project Settings > Plugins

### Method 3: Use as a Singleton (Autoload)

1. **Copy the script** to your project
2. **Go to Project Settings > Autoload**
3. **Add the script** as a singleton
4. **Access from anywhere:**
   ```gdscript
   DiceAnimation.start_animation()
   DiceAnimation.animation_finished.connect(_on_dice_finished)
   ```

## Customization

### Changing Animation Duration
```gdscript
# In the editor or code
dice.animation_duration = 3.0  # 3 seconds
```

### Custom Sprite Loading
Modify the `_load_dice_sprites()` function to load from different paths or use different naming conventions.

### Adding Sound Effects
```gdscript
@onready var roll_sound: AudioStreamPlayer = $RollSound

func start_animation():
    roll_sound.play()
    # ... rest of animation code
```

## Troubleshooting

- **Sprites not loading:** Check that your sprites are in the correct folder and have the right file extensions
- **Animation not starting:** Ensure you have at least 6 sprites loaded
- **Script errors:** Make sure you're using Godot 4.x (the script uses Godot 4 syntax)

## License

This code is provided as-is for educational and commercial use. Feel free to modify and distribute as needed.

