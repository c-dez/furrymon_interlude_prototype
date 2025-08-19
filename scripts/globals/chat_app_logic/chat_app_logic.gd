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
	# cambios de atributos en command deben de seguir una sintaxis exacta
	# ejemplo: "flarya interes - 1" ==  (furry_name) (atribute) (operator) (value)
	#similar a un comando de terminal
	var text: String = command
	var split_text: Array = text.split(" ")
	var furry_name: String = split_text[0]
	var atribute: String = split_text[1]
	var operator: String = split_text[2]
	var value: int = split_text[3].to_int()
	# notificar error de sintaxis en command
	if split_text.size() != 4:
		# checa si se cumple con el numero de comandos, por ahora solo 4
		print("command error de sintaxis: ", split_text)
		return

	match furry_name:
		#base de como se evaluan comandos, falta cambiarlo a codigo mas limpio
		"flarya":
			if atribute == "interes":
				if operator == "+":
					PlayerStats.player_stats["flarya"]["interes"] += value
					print(PlayerStats.player_stats["flarya"]["interes"])
				elif operator == "-":
					PlayerStats.player_stats["flarya"]["interes"] -= value
					print(PlayerStats.player_stats["flarya"]["interes"])
			else:
				print("atribute: ", atribute, " no reconocido en command: ", split_text)
		_:
			print(furry_name, "no reconocido")
