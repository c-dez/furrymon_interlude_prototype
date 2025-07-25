class_name RightChatBox
extends HBoxContainer


@onready var color_rect:ColorRect = get_node('ColorRect')
@onready var label: Label = color_rect.get_node("Label")

func _ready() -> void:
	label.text = "placeholder"
	pass