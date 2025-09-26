extends Control

signal novo_valor(valor)

@export var val_atual = 5

func _draw() -> void:
	$SpinBox.value = val_atual
	$ColorRect.grab_focus()


func _on_color_rect_mouse_exited() -> void:
	self.queue_free()

func _on_color_rect_focus_exited() -> void:
	self.queue_free()

func _on_spin_box_value_changed(value: float) -> void:
	novo_valor.emit(int(value))
