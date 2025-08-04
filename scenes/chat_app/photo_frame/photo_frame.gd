class_name PhotoFrame
extends Control

# view_port contiene como childs Sprite2D para almacenar las imagenes que se van a mostrar
@onready var view_port: SubViewportContainer = get_node("SubViewportContainer")


func _ready() -> void:
	check_if_no_images_in_view_port()


func check_if_no_images_in_view_port() -> void:
	if view_port.get_child_count() == 0:
		print("no images in PhotoFrame")
	else:
		for i in range(view_port.get_child_count()):
			var node: Node
			node = view_port.get_child(i)
			print(node.name)