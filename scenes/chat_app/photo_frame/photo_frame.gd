class_name PhotoFrame
extends Control

# view_port contiene como childs Sprite2D para almacenar las imagenes que se van a mostrar
@onready var _view_port: SubViewportContainer = get_node("SubViewportContainer")
@onready var sprite: Sprite2D = _view_port.get_node("Sprite2D")

var sprite_texture_path: String

func _ready() -> void:
	if sprite.texture == null:
		print("null")
