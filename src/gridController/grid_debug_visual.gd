extends Sprite2D

func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(160, 160)), Color(0.467, 0.792, 0.98, 0.086), true)
	draw_rect(Rect2(Vector2(0, 0), Vector2(161, 160)), Color(0.538, 0.748, 0.945, 0.922), false)
	for i in range(get_parent().GRID_WIDTH):
		for j in range(get_parent().GRID_HEIGHT):
			draw_rect(Rect2(Vector2(0 + 16 * i, 0 + 16 * j), Vector2(16, 16)), Color(0.263, 0.557, 0.812, 0.031), false)
			
