extends Sprite2D

var bubble_Scene = preload("res://gridController/bubbleScene/bubbleScene.tscn")
var count = 0
var timer = randi_range(90, 120)
func _draw():
	
	draw_rect(Rect2(Vector2(0, 0), Vector2(160, 160)), Color(0.467, 0.792, 0.98, 0.086), true)
	draw_rect(Rect2(Vector2(0, 0), Vector2(161, 160)), Color(0.216, 0.501, 0.745, 0.922), false)
	
	for i in range(get_parent().GRID_WIDTH):
		for j in range(get_parent().GRID_HEIGHT):
			draw_rect(Rect2(Vector2(0 + 16 * i, 0 + 16 * j), Vector2(16, 16)), Color(0.263, 0.557, 0.812, 0.031), false)
			
func _process(delta: float) -> void:
	count+=1
	if count == timer:
		count = 0
		timer = randi_range(30, 45)
		for i in range(0, randi_range(1, 2)):
			spawn_bubble()
			
func spawn_bubble():
	var bubble = bubble_Scene.instantiate()
	bubble.position.x = randi_range(16, 144)
	bubble.position.y = 144
	bubble.modulate.a = randf_range(0.10, 0.60)
	var scale = randf_range(0.5, 1)
	bubble.scale = Vector2(scale, scale)
	add_child(bubble)
