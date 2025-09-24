# Forest 'n' Funds 🎮🌱

A strategic board game where every financial decision you make nurtures growth. Invest wisely, trade smart, and watch your forest flourish—or wither—based on your money moves. The goal: balance wealth and nature to become the ultimate eco-tycoon.

## 🎲 Game Rules

### Core Flow
1. **Start**: Player begins with ₹5000 and 24 dice rolls
2. **Roll**: Roll dice → move that many tiles along the 24-tile path
3. **Land**: Modal pops up with tile details and options:
   - **Category tiles** (Food/Health/Education/Travel/Luxury) → choose Spend or Skip
   - **Investment tiles** (2 total) → deposit ₹200 for 25% return + travel growth
   - **Gamble tiles** (2 total) → pay ₹100 for 50% win/lose chance
4. **Skip Penalty**: Skip 3 times in a row → random plant loses 5 growth
5. **Plants**: Growth 0-100 with 4 stages (seed, sapling, plant, full-flowered)
6. **End**: After 24 rolls, win if total growth ≥ 300 OR 2+ plants full-flowered AND money ≥ 0

### Win Conditions
- **Win**: Total growth ≥ 300 OR at least 2 plants full-flowered (≥75) AND money ≥ 0
- **Lose**: Money < 0 (bankruptcy) OR win condition not met at game end

## 🌱 Plant Categories

### Food Plants
- Farm Fresh Groceries (₹200 → +12 growth)
- Street Snacks (₹120 → +7 growth)
- Organic Feast (₹300 → +18 growth)
- Family Dinner Night (₹180 → +10 growth)

### Health Plants
- Doctor Visit (₹250 → +15 growth)
- Gym Subscription (₹200 → +12 growth)
- Emergency Medicine (₹300 → +20 growth)
- Yoga Retreat (₹180 → +10 growth)

### Education Plants
- Book Purchase (₹200 → +12 growth)
- Online Course (₹250 → +15 growth)
- College Tuition (₹350 → +22 growth)
- Workshop Event (₹180 → +10 growth)

### Travel Plants
- Weekend Getaway (₹220 → +12 growth)
- Long Vacation (₹350 → +20 growth)
- Train Journey (₹180 → +9 growth)
- Cultural Tour (₹250 → +14 growth)

### Luxury Plants
- Designer Clothes (₹280 → +12 growth)
- Fancy Car Ride (₹320 → +14 growth)
- Fine Dining (₹220 → +10 growth)
- Gadget Upgrade (₹300 → +15 growth)

## 🎰 Special Tiles

### Investment Tiles (2 total)
- **Investment Bank** & **Stock Market**
- Pay ₹200 → get back ₹250 (25% profit) + 6 travel growth at game end

### Gamble Tiles (2 total)
- **Casino Night** & **Lottery Stall**
- Pay ₹100 → 50% chance: +₹200 and +8 random plant growth, else -6 random plant growth

## 🚀 How to Play

1. Open the project in Godot 4.5+
2. Run the main scene (`Main.tscn`)
3. Click "Roll Dice" to start moving
4. When you land on a tile, choose to Spend or Skip
5. Manage your money and plant growth carefully
6. Try to win before running out of dice rolls!

## 🛠️ Technical Implementation

- **Main.gd**: Core game logic, state management, and game flow
- **GameUI.gd**: User interface and modal system
- **Main.tscn**: Main game scene with UI layout
- **GameTest.gd**: Automated tests for game mechanics

### Key Features
- ✅ Complete tile system with 24 unique tiles
- ✅ Plant growth tracking with 4 growth stages
- ✅ Modal popup system for tile interactions
- ✅ Skip penalty system (3 skips = random plant -5 growth)
- ✅ Win/lose condition checking
- ✅ Investment system with 25% returns
- ✅ Gamble system with risk/reward mechanics
- ✅ UI for displaying game state and plant status

## 🎯 Strategy Tips

- Balance spending on different plant categories
- Use investments for guaranteed returns
- Be careful with gambling - it's risky!
- Don't skip too many tiles in a row
- Plan your spending to avoid bankruptcy
- Aim for either high total growth OR multiple full-flowered plants

Enjoy growing your forest and managing your funds! 🌳💰
