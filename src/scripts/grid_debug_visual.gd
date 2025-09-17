extends Sprite2D

func _draw():
	for i in range(get_parent().GRID_WIDTH):
		for j in range(get_parent().GRID_HEIGHT):
			draw_rect(Rect2(Vector2(0 + 16 * i, 0 + 16 * j), Vector2(16, 16)), Color(0.261, 0.556, 0.813, 1.0), false)
			
