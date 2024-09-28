@tool
class_name HexTileMesh
extends MeshInstance3D

const GRASS_MATERIAL = 0
const SAND_MATERIAL = 1

@onready var GRASS = load("res://materials/grass.tres")
@onready var SAND = load("res://materials/sand.tres")

@export var is_pointy: bool = true
@export var size: float = 1.0
@export var material_index: int = 0

var _pointy_hex_vertices
var _flat_hex_vertices

func init(_size: float = 1.0, _material_index: int = 0, _is_pointy: bool = true):
	size = _size
	material_index = _material_index
	is_pointy = _is_pointy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_pointy_hex_vertices = pointy_hex_vertices(
		Vector3.ZERO,
		size
	)
	_flat_hex_vertices = flat_hex_vertices(
		Vector3.ZERO,
		size
	)
	update_vertices()
	update_material()

func set_material_index(_material_index: int):
	material_index = _material_index
	update_material()

func set_pointy_top():
	is_pointy = true
	update_vertices()
	update_material()

func set_flat_top():
	is_pointy = false
	update_vertices()
	update_material()

func update_material() -> void:
		match material_index:
			0:
				set_surface_override_material(0, GRASS)
			1:
				set_surface_override_material(0, SAND)
			_:
				set_surface_override_material(0, GRASS)
				
func update_vertices() -> void:
	var verts
	if is_pointy:
		verts = PackedVector3Array(_pointy_hex_vertices)
	else:
		verts = PackedVector3Array(_flat_hex_vertices)
	
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	surface_array[Mesh.ARRAY_VERTEX] = verts
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
	

func pointy_hex_corner(center: Vector3, _size: float, i: int) -> Vector3:
	var angle_deg = 60 * i - 30
	var angle_rad = PI / 180 * angle_deg
	return Vector3(
		center.x + _size * cos(angle_rad),
		0,
		center.y + _size * sin(angle_rad)
	)

func flat_hex_corner(center: Vector3, _size: float, i: int) -> Vector3:
	var angle_deg = 60 * i
	var angle_rad = PI / 180 * angle_deg
	return Vector3(
		center.x + _size * cos(angle_rad),
		0,
		center.y + _size * sin(angle_rad)
	)

func pointy_hex_vertices(center: Vector3, _size: float) -> Array:
	var corner_0 = pointy_hex_corner(center, _size, 0)
	var corner_1 = pointy_hex_corner(center, _size, 1)
	var corner_2 = pointy_hex_corner(center, _size, 2)
	var corner_3 = pointy_hex_corner(center, _size, 3)
	var corner_4 = pointy_hex_corner(center, _size, 4)
	var corner_5 = pointy_hex_corner(center, _size, 5)
	
	return [
		center, corner_0, corner_1,
		center, corner_1, corner_2,
		center, corner_2, corner_3,
		center, corner_3, corner_4,
		center, corner_4, corner_5,
		center, corner_5, corner_0
	]

func flat_hex_vertices(center: Vector3, _size: float) -> Array:
	var corner_0 = flat_hex_corner(center, _size, 0)
	var corner_1 = flat_hex_corner(center, _size, 1)
	var corner_2 = flat_hex_corner(center, _size, 2)
	var corner_3 = flat_hex_corner(center, _size, 3)
	var corner_4 = flat_hex_corner(center, _size, 4)
	var corner_5 = flat_hex_corner(center, _size, 5)
	
	return [
		center, corner_0, corner_1,
		center, corner_1, corner_2,
		center, corner_2, corner_3,
		center, corner_3, corner_4,
		center, corner_4, corner_5,
		center, corner_5, corner_0
	]
