extends Node2D

# Tile sprite paths for different types
var tile_sprite_paths = {
	# Food tiles
	"Farm Fresh Groceries": "res://Archive/tiles/farm-fresh.png",
	"Street Snacks": "res://Archive/tiles/street-snacks.png",
	"Organic Feast": "res://Archive/tiles/organic-feast.png",
	"Family Dinner Night": "res://Archive/tiles/family-dinner-night.png",
	
	# Health tiles
	"Doctor Visit": "res://Archive/tiles/doctor-visit.png",
	"Gym Subscription": "res://Archive/tiles/gym-subscription.png",
	"Emergency Medicine": "res://Archive/tiles/emergency-medicine.png",
	"Yoga Retreat": "res://Archive/tiles/yoga-retreat.png",
	
	# Education tiles
	"Book Purchase": "res://Archive/tiles/book-purchase.png",
	"Online Course": "res://Archive/tiles/online-course.png",
	"College Tuition": "res://Archive/tiles/college-tuition.png",
	"Workshop Event": "res://Archive/tiles/workshop-event.png",
	
	# Travel tiles
	"Weekend Getaway": "res://Archive/tiles/weekend-getaway.png",
	"Long Vacation": "res://Archive/tiles/long-vacation.png",
	"Train Journey": "res://Archive/tiles/train-journey.png",
	"Cultural Tour": "res://Archive/tiles/cultural-tour.png",
	
	# Luxury tiles
	"Designer Clothes": "res://Archive/tiles/designer-clothes.png",
	"Fancy Car Ride": "res://Archive/tiles/fancy-car-ride.png",
	"Fine Dining": "res://Archive/tiles/fine-dining.png",
	"Gadget Upgrade": "res://Archive/tiles/gadeget-upgrade.png",
	
	# Special tiles
	"Investment Bank": "res://Archive/tiles/investment-bank.png",
	"Stock Market": "res://Archive/tiles/stock-market.png",
	"Casino Night": "res://Archive/tiles/casino-night.png",
	"Lottery Stall": "res://Archive/tiles/lottery-stall.png"
}

func get_tile_sprite_path(tile_name: String) -> String:
	if tile_name in tile_sprite_paths:
		return tile_sprite_paths[tile_name]
	return ""

