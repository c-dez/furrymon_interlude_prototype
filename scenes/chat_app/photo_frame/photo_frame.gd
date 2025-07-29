class_name PhotoFrame
extends Control


@onready var view_port = get_node("SubViewportContainer")
@onready var frame_knight = view_port.get_child(0)
@onready var frame_furry = view_port.get_child(1)

func _ready() -> void:
	frame_furry.visible = false