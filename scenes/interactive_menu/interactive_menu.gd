class_name InteractiveMenu
extends Control


@onready var scroll_container: ScrollContainer = get_node("ScrollContainer")
@onready var v_box: VBoxContainer = scroll_container.get_node("VBoxContainer")

var left_chat: Resource = preload("res://scenes/interactive_menu/chat_boxes/left/left_chat_box.tscn")
var right_chat: Resource = preload("res://scenes/interactive_menu/chat_boxes/right/right_chat_box.tscn")


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        var instance: Node = left_chat.instantiate()
        v_box.add_child(instance)
        # asegurarse que el scroll se baje para que el nuevo nodo sea visible
        await get_tree().process_frame
        scroll_container.ensure_control_visible(instance)
    
    
    pass