class_name ChatApp
extends Control
# este nodo se encarga de crear las cajas de texto, su contenido y scroll


@onready var scroll_container: ScrollContainer = get_node("ScrollContainer")
@onready var v_box_container: VBoxContainer = scroll_container.get_node("VBoxContainer")
@onready var photo_frame: PhotoFrame = get_node("../PhotoFrame")

# text boxes
const left_chat: Resource = preload("res://scenes/chat_app/chat_boxes/left/left_chat_box.tscn")
const right_chat: Resource = preload("res://scenes/chat_app/chat_boxes/right/right_chat_box.tscn")
const options_btns: Resource = preload("res://scenes/chat_app/chat_boxes/options_btns/options_btns.tscn")

#referencia a el dialogo
var dialog_path: String = "res://dialogos/dialogos_red.json"

var dialogo_actual: Dictionary = {}
var index: int = 0


enum BRANCHES {
	branch_1,
	branch_2
}
var current_branch: int = BRANCHES.branch_1
var input_enable: bool = true
var text_commands: Array = []

var player_id: String = PlayerStats.player_stats["player_id"]

# signals
## para cambiar atributos eje. interes + 1
signal command_atribute_signal(command: String)
# single command
signal command_single_signal(command:String,photo_frame:PhotoFrame)


func _ready() -> void:
	dialogo_actual = load_dialog(dialog_path)
	# signal emitida hacia:
	command_atribute_signal.connect(ChatAppLogic._on_command_atribute_signal)
	command_single_signal.connect(ChatAppLogic._on_command_single_signal)
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and input_enable:
		print_linea()


func print_linea() -> void:
	# se encarga de ir leyendo y decidiendo que lineas de dialogo y donde se van a "imprimir"
	if dialogo_actual == {}:
		# cuando termina el dialogo
		print("dialogo empty")
		return

	var personaje: String = dialogo_actual["personaje"]
	var lineas: Array = dialogo_actual["lineas"]
	var lineas_2: Array = []

	text_commands = text_command_assign()
	lineas_2 = lineas_2_assign()

	if index < lineas.size():
		match personaje:
			player_id:
				text_command_read()
				right_chat_box_behavior(lineas, lineas_2)
			"opciones":
				options_btns_behavior(lineas, lineas_2)
			_:
				left_chat_box_behavior(lineas, lineas_2)
	else:
		text_command_read()
		advance_dialog()


func load_dialog(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	var contenido: String = file.get_as_text()
	var datos: Dictionary = JSON.parse_string(contenido)
	return datos


func _on_option_1_pressed(btn1: Button, btn2: Button) -> void:
	command_atribute_signal.emit(text_commands[0])
	input_enable = true
	current_branch = BRANCHES.branch_1
	btn1.disabled = true
	btn2.disabled = true
	btn2.text = ""
	text_commands = []
	print_linea()


func _on_option_2_pressed(btn1: Button, btn2: Button) -> void:
	command_atribute_signal.emit(text_commands[1])
	input_enable = true
	current_branch = BRANCHES.branch_2
	btn1.disabled = true
	btn2.disabled = true
	btn1.text = ""
	text_commands = []
	print_linea()


func text_command_assign() -> Array:
	var _text_command: Array
	# asigna el contenido de text_commands si
	if dialogo_actual.has("command"):
		_text_command = dialogo_actual["command"]
		# mandar senal para manjear el comportamiento segun  _text_command
	else:
		_text_command = []
	return _text_command


func lineas_2_assign() -> Array:
	var _lineas_2: Array
	if dialogo_actual.has("lineas_2"):
		if index < dialogo_actual["lineas_2"].size():
			_lineas_2 = dialogo_actual["lineas_2"]
		else:
			_lineas_2 = []
	return _lineas_2
	

func scroll_to_bottom(instance: Node) -> void:
	# asegurarse que el scroll se baje para que el nuevo nodo sea visible
	await get_tree().process_frame
	scroll_container.ensure_control_visible(instance)


func options_btns_behavior(lineas: Array, lineas_2: Array) -> void:
	input_enable = false
	var instance: OptionsBtns = options_btns.instantiate()
	v_box_container.add_child(instance)
	instance.option_1.text = lineas[0]
	instance.option_2.text = lineas_2[0]
	# signals
	instance.option_1.connect("pressed", Callable(self, "_on_option_1_pressed").bind(instance.option_1, instance.option_2))
	instance.option_2.connect("pressed", Callable(self, "_on_option_2_pressed").bind(instance.option_1, instance.option_2))
	index += 1
	scroll_to_bottom(instance)


func right_chat_box_behavior(lineas: Array, lineas_2: Array) -> void:
	var instance: RightChatBox = right_chat.instantiate()
	v_box_container.add_child(instance)
	if current_branch == BRANCHES.branch_1:
		instance.label.text = lineas[index]
	else:
		instance.label.text = lineas_2[index]
	index += 1
	scroll_to_bottom(instance)


func left_chat_box_behavior(lineas: Array, lineas_2: Array) -> void:
	var instance: LeftChatBox = left_chat.instantiate()
	v_box_container.add_child(instance)
	if current_branch == BRANCHES.branch_1:
		instance.label.text = lineas[index]
	else:
		instance.label.text = lineas_2[index]
	index += 1
	scroll_to_bottom(instance)


func advance_dialog() -> void:
	if dialogo_actual.has("siguiente"):
		dialogo_actual = dialogo_actual["siguiente"]
		index = 0
		print_linea()
	else:
		print("fin de dialogo")
		dialogo_actual = {}
		index = 0

## funcion en desarrollo nombre va a cambiar para reflejar mejor su intencion
func text_command_read():	
	# testing
	# command en json continene un array, con  dos commandos para cada uno de los botones de opciones o puede contener solo un comando para acciones como cambiar imagen, reproducir sonidos etc... , por ahora cumple estas dos funciones:
		# pensar si se conserva esta estructura y crear los comportamientos necesarios para manejarlas correctamente no me agrada darle dos responsabilidades, pero ya esta hecho este sistema
		# o separar estas responsabilidades, se apega a buenas practicas pero puede volver mas complejo el sistema, por que tengo que agregar otro sistema que se encargue de cambiar imagenes
	if text_commands.size() == 1:
		# por ahora solo se encarga de verificar que solo exista un comando dentro de el array, si es asi se trata este comando de forma distinta a que si fuera commando para botones de opciones que contienen 2 elementos  dentro de el array
		# print(text_commands[0])
		command_single_signal.emit(text_commands[0],photo_frame)
		# photo_frame.sprite_texture_path = ChatAppLogic.sprite_path

	pass
