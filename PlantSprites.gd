extends Node2D

# Plant sprite paths for different categories and growth stages
var plant_sprite_paths = {
	"Food": {
		"seed": "res://Archive/plants/food/food-seed-stage.png",
		"sapling": "res://Archive/plants/food/food-sapling-stage.png",
		"plant": "res://Archive/plants/food/food-plant-stage.png",
		"flowered": "res://Archive/plants/food/food-flowered-stage.png"
	},
	"Health": {
		"seed": "res://Archive/plants/health/health-seed-stage.png",
		"sapling": "res://Archive/plants/health/health-sapling-stage.png",
		"plant": "res://Archive/plants/health/health-plant-stage.png",
		"full-flowered": "res://Archive/plants/health/health-full-flowered-stage.png"
	},
	"Education": {
		"seed": "res://Archive/plants/education/education-seed-stage.png",
		"sapling": "res://Archive/plants/education/education-sapling-stage.png",
		"plant": "res://Archive/plants/education/education-plant-stage.png",
		"full-flowered": "res://Archive/plants/education/education-full-flowered-stage.png"
	},
	"Travel": {
		"seed": "res://Archive/plants/travel/travel-seed-stage.png",
		"sapling": "res://Archive/plants/travel/travel-sapling-stage.png",
		"plant": "res://Archive/plants/travel/travel-plant-stage.png",
		"fully-flowered": "res://Archive/plants/travel/travel-fully-flowered.png"
	},
	"Luxury": {
		"seed": "res://Archive/plants/luxury/luxury-seed-stage.png",
		"sapling": "res://Archive/plants/luxury/luxury-sapling-stage.png",
		"plant": "res://Archive/plants/luxury/luxury-plant-stage.png",
		"fully-flowered": "res://Archive/plants/luxury/luxury-fully-flowered-stage.png"
	}
}

func get_plant_sprite_path(category: String, stage: String) -> String:
	if category in plant_sprite_paths and stage in plant_sprite_paths[category]:
		return plant_sprite_paths[category][stage]
	return ""

