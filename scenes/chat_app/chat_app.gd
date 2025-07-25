class_name ChatApp # no me gusta este nombre cambiarlo por algo mas descriptivo
extends Control
# este nodo se encarga de crear las cajas de texto, su contenido y scroll

@onready var scroll_container: ScrollContainer = get_node("ScrollContainer")
@onready var v_box: VBoxContainer = scroll_container.get_node("VBoxContainer")

var left_chat: Resource = preload("res://scenes/chat_app/chat_boxes/left/left_chat_box.tscn")
var right_chat: Resource = preload("res://scenes/chat_app/chat_boxes/right/right_chat_box.tscn")
#optionsBtns
var options_btns: Resource = preload("res://scenes/chat_app/chat_boxes/options_btns/options_btns.tscn")

var dialogo_actual = {}
var index: int = 0


var text_content: String

func _ready() -> void:
	dialogo_actual = load_dialog("res://dialogos/dialogo.json") as Dictionary
	print("presiona enter para avanzar")
	
	pass


func _process(_delta: float) -> void:
	# test
	# crea un nodo y baja el scroll bar
	if Input.is_action_just_pressed("ui_accept"):
		imprimir_linea()
		pass


	pass

# func imprimir_opciones() -> void:
# 	var instance: OptionsBtns = options_btns.instantiate()
# 	v_box.add_child(instance)
# 	instance.option_1.text = "texto1"
# 	instance.option_2.text = "texto2"
# 	#senales
# 	instance.option_1.connect("pressed", Callable(self, "_on_option_1_pressed").bind(instance.option_1.text))
# 	instance.option_2.connect("pressed", Callable(self, "_on_option_2_pressed").bind(instance.option_2.text))

# 	await get_tree().process_frame
# 	scroll_container.ensure_control_visible(instance)


func _on_option_1_pressed(text):
	print(text)


func _on_option_2_pressed(text):
	print(text)


func imprimir_linea() -> void:
	if dialogo_actual == null:
		# print("dialogo null")
		return

	var lineas: Array = dialogo_actual["lineas"]
	var personaje: String = dialogo_actual["personaje"]

	if index < lineas.size():
		if personaje == "Caballero":
			var instance: RightChatBox = right_chat.instantiate()
			v_box.add_child(instance)
			instance.label.text = lineas[index]
			# asegurarse que el scroll se baje para que el nuevo nodo sea visible
			await get_tree().process_frame
			scroll_container.ensure_control_visible(instance)
			index += 1
		elif personaje == "opciones":
			var instance: OptionsBtns = options_btns.instantiate()
			v_box.add_child(instance)
			# para evitar problemas lineas que es un array, contiene un array y este array contiene las dos opciones por eso las dos siguientes lineas
			instance.option_1.text = lineas[0][0]
			instance.option_2.text = lineas[0][1]
			#senales
			instance.option_1.connect("pressed", Callable(self, "_on_option_1_pressed").bind(instance.option_1.text))
			instance.option_2.connect("pressed", Callable(self, "_on_option_2_pressed").bind(instance.option_2.text))

			await get_tree().process_frame
			scroll_container.ensure_control_visible(instance)
			index += 1
		else:
			var instance: LeftChatBox = left_chat.instantiate()
			v_box.add_child(instance)
			instance.label.text = lineas[index]
			
			# asegurarse que el scroll se baje para que el nuevo nodo sea visible
			await get_tree().process_frame
			scroll_container.ensure_control_visible(instance)
			index += 1
	else:
		if dialogo_actual.has("siguiente"):
			dialogo_actual = dialogo_actual["siguiente"]
			index = 0
			imprimir_linea()
		else:
			print("fin de dialogo")
			dialogo_actual = null
	

func load_dialog(ruta: String):
	var archivo := FileAccess.open(ruta, FileAccess.READ)
	var contenido: String = archivo.get_as_text()
	var datos: Dictionary = JSON.parse_string(contenido)
	return datos
