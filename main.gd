extends Node3D

@onready var hex_tile: HexTileMesh = $Board/HexTile

func _ready() -> void:
	hex_tile.init(1.0, hex_tile.SAND_MATERIAL)


func _on_grass_button_pressed() -> void:
	hex_tile.set_material_index(hex_tile.GRASS_MATERIAL)

func _on_sand_button_pressed() -> void:
	hex_tile.set_material_index(hex_tile.SAND_MATERIAL)


func _on_pointy_top_button_pressed() -> void:
	hex_tile.set_pointy_top()

func _on_flat_top_button_pressed() -> void:
	hex_tile.set_flat_top()
