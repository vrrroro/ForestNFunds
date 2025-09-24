extends Node2D

# Plant growth stages
enum GrowthStage {
	SEED,
	SAPLING,
	PLANT,
	FULL_FLOWERED
}

var growth_stage: GrowthStage = GrowthStage.SEED
var growth_amount: int = 0
var plant_category: String = ""
var sprite: Sprite2D

func _ready():
	# Create sprite node
	sprite = Sprite2D.new()
	add_child(sprite)
	update_visual()

func set_growth(amount: int, category: String):
	growth_amount = amount
	plant_category = category
	update_growth_stage()
	update_visual()

func update_growth_stage():
	if growth_amount >= 75:
		growth_stage = GrowthStage.FULL_FLOWERED
	elif growth_amount >= 50:
		growth_stage = GrowthStage.PLANT
	elif growth_amount >= 25:
		growth_stage = GrowthStage.SAPLING
	else:
		growth_stage = GrowthStage.SEED

func update_visual():
	if sprite:
		var texture_path = get_sprite_path()
		if texture_path != "":
			var texture = load(texture_path)
			if texture:
				sprite.texture = texture
				# Scale the sprite to appropriate size
				sprite.scale = Vector2(0.3, 0.3)  # Adjust scale as needed

func get_sprite_path() -> String:
	var stage_name = ""
	match growth_stage:
		GrowthStage.SEED:
			stage_name = "seed"
		GrowthStage.SAPLING:
			stage_name = "sapling"
		GrowthStage.PLANT:
			stage_name = "plant"
		GrowthStage.FULL_FLOWERED:
			# Handle different naming conventions for full-flowered stage
			if plant_category == "Food":
				stage_name = "flowered"
			elif plant_category == "Travel" or plant_category == "Luxury":
				stage_name = "fully-flowered"
			else:
				stage_name = "full-flowered"
	
	var sprite_data = load("res://PlantSprites.gd").new()
	return sprite_data.get_plant_sprite_path(plant_category, stage_name)
