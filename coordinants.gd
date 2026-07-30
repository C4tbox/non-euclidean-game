extends Label

func _on_character_body_3d_coords(pos: Variant) -> void:
	text = "Y: " + str(pos.y).pad_decimals(1) + ", X: " + str(pos.x).pad_decimals(1) + ", Z: " + str(pos.z).pad_decimals(1)
