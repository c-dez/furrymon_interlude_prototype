class_name ChatBox
extends Control


@onready var label :Label = get_node('Label')

func _ready() -> void:
	label.size = size
	print(label.size," ", size)
	