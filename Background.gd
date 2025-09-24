extends Node2D

func _ready():
	queue_redraw()

func _draw():
	# Draw a simple forest background
	draw_background()
	draw_trees()

func draw_background():
	# Draw sky gradient
	var sky_color = Color(0.5, 0.8, 1.0)  # Light blue
	var ground_color = Color(0.3, 0.6, 0.3)  # Green
	
	# Sky
	draw_rect(Rect2(0, 0, 800, 400), sky_color)
	
	# Ground
	draw_rect(Rect2(0, 400, 800, 200), ground_color)

func draw_trees():
	# Draw simple trees in the background
	var tree_positions = [Vector2(100, 350), Vector2(200, 380), Vector2(300, 360), 
						  Vector2(500, 370), Vector2(600, 340), Vector2(700, 375)]
	
	for pos in tree_positions:
		draw_tree(pos)

func draw_tree(pos: Vector2):
	# Draw tree trunk
	draw_line(pos, pos + Vector2(0, 50), Color(0.4, 0.2, 0.1), 8)
	
	# Draw tree leaves
	draw_circle(pos + Vector2(0, -10), 25, Color(0.2, 0.6, 0.2))
	draw_circle(pos + Vector2(-15, -5), 20, Color(0.2, 0.6, 0.2))
	draw_circle(pos + Vector2(15, -5), 20, Color(0.2, 0.6, 0.2))
