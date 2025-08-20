extends Node

# global
# se hace cargo de ejecutar acciones segun el command de json

var image_scale := Vector2(0.3, 0.3)

func _on_command_atribute_signal(command: String) -> void:
	# signal recibida desde "chat_app.gd"
	command_atribute_decisions(command)
	

func _on_command_single_signal(command: String, photo_frame: PhotoFrame) -> void:
	# signal recibida desde "chat_app.gd"
	command_single_decision(command, photo_frame)


func command_single_decision(command: String, photo_frame: PhotoFrame) -> void:
	# compara command en match y:
	# crea un Sprite2D, y lo configura
	# falta estandarizar commands
	match command:
		"flarya_1":
			create_image_sprite(photo_frame, PortraitsPaths.flarya_1)
		"flarya_2":
			create_image_sprite(photo_frame, PortraitsPaths.flarya_2)
		_:
			pass


func create_image_sprite(photo_frame: PhotoFrame, image_resource: Resource) -> void:
	var image: Resource = image_resource
	# se asegura de que no exista mas de un child
	if photo_frame.view_port.get_child_count() > 0:
		for i in range(photo_frame.view_port.get_child_count()):
			photo_frame.view_port.get_child(i).queue_free()
			
	var new_sprite := Sprite2D.new()
	photo_frame.view_port.add_child(new_sprite)
	new_sprite.texture = image
	new_sprite.centered = false
	new_sprite.scale = image_scale


func command_atribute_decisions(command: String):
	# command en dialogo debe de seguir sintaxis exacta
	# ejemplo: "flarya interes -1" ==  (furry_name) (atribute) (value)
	var split_text: Array = command.split(" ")

	
	if split_text.size() != 3:
		# checa si se cumple con el numero de comandos, por ahora solo 3
		printerr("command error de sintaxis: ", split_text)
		_print_syntaxis_example()
		return

	var furry_name: String = split_text[0]
	var atribute: String = split_text[1]
	var value_str: String = split_text[2]

	if not value_str.is_valid_int():
		printerr("value no es int ", value_str)
		_print_syntaxis_example()
		return

	var value: int = value_str.to_int()

	const INTERES: String = "interes"
	const FLARYA: String = "flarya"
	match furry_name:
		# base de como se evaluan comandos
		FLARYA:
			if atribute == INTERES:
				PlayerStats.set_atribute(value, furry_name, atribute)
				print(PlayerStats.get_atribute(furry_name, atribute))
			else:
				printerr("atribute: ", atribute, " no reconocido en command: ", split_text)
				_print_syntaxis_example()
		_:
			printerr(furry_name, "no reconocido")
			_print_syntaxis_example()





# debug
func _print_syntaxis_example() -> void:
		printerr("sintaxis es: flarya interes -1 (furry_name) (atribute) (value)")