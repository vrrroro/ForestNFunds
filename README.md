# Forest 'n' Funds

A board game built in Godot where players manage money and grow different types of plants by making strategic spending decisions.

## Game Overview

Forest 'n' Funds is a strategic board game where players:
- Start with ₹5000 and 24 dice rolls
- Move around a circular board with 24 tiles
- Spend money on different categories to grow plants
- Win by achieving either:
  - Total plant growth ≥ 300, OR
  - At least 2 plants reach full-flowered stage (≥75 growth)
  - While maintaining positive money

## Plant Categories

1. **Food** - Green plants representing nutrition and sustenance
2. **Health** - Red plants representing medical and wellness spending
3. **Education** - Blue plants representing learning and knowledge
4. **Travel** - Cyan plants representing exploration and experiences
5. **Luxury** - Purple plants representing premium and indulgent spending

## Tile Types

- **Category Tiles (20)**: Spend money to grow specific plant types
- **Investment Tiles (2)**: Deposit money for 25% return at game end + travel growth
- **Gamble Tiles (2)**: Risk money for chance of big rewards or losses

## How to Play

1. Click "Roll Dice" to move around the board
2. When you land on a tile, choose to:
   - **Spend**: Pay the cost to get the benefits
   - **Skip**: Avoid the cost but risk penalties after 3 skips
3. Manage your money carefully - going negative means game over
4. Try to reach the win conditions before running out of dice rolls

## Running the Game

1. Open the project in Godot 4.x
2. Set `Main.tscn` as the main scene
3. Run the project (F5 or click the play button)
4. Use the UI to roll dice and make decisions

## Game Mechanics

- **Plant Growth Stages**: Seed → Sapling → Plant → Full-Flowered
- **Skip Penalty**: After 3 consecutive skips, a random plant loses 5 growth
- **Investment Returns**: 25% profit + 6 travel growth at game end
- **Gambling**: 50% chance to win ₹200 + 8 random growth, or lose 6 random growth

## Files Structure

- `Main.gd` - Main game logic and state management
- `GameBoard.gd` - Visual board and tile management
- `GameUI.gd` - User interface and modal handling
- `PlantSprite.gd` - Individual plant visual representation using PNG assets
- `TileSprite.gd` - Individual tile visual representation using PNG assets
- `Background.gd` - Forest background rendering
- `PlantSprites.gd` - Plant sprite path management
- `TileSprites.gd` - Tile sprite path management
- `GameTest.gd` - Automated game mechanics testing

## Visual Assets

The game uses high-quality PNG sprites from the `Archive/` folder:

### Plant Sprites
- **5 Categories**: Food, Health, Education, Travel, Luxury
- **4 Growth Stages**: Seed → Sapling → Plant → Full-Flowered
- **20 Unique Sprites**: Each plant category has distinct visual progression

### Tile Sprites
- **20 Category Tiles**: Unique artwork for each spending opportunity
- **4 Special Tiles**: Investment and gambling tiles with distinct visuals
- **Professional Artwork**: High-quality PNG assets for immersive gameplay

Enjoy growing your forest and managing your funds!