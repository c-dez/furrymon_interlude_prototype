extends Node

# global
# se hace cargo de ejecutar acciones segun el command de json


func _on_command_atribute_signal(command: String) -> void:
	# signal recibida desde "chat_app.gd"
	command_atribute_decisions(command)
	

func _on_command_single_signal(command, photo_frame):
	# signal recibida desde "chat_app.gd"
	command_single_decision(command, photo_frame)


func command_single_decision(command: String, photo_frame: PhotoFrame) -> void:
	# al recibir  este command
	if command == "flarya_1":
		# se asegura de borrar todos los childs si existen
		if photo_frame.view_port.get_child_count() > 0:
			for i in range(photo_frame.view_port.get_child_count()):
				photo_frame.view_port.get_child(i).queue_free()
		# crea un Sprite2D, y lo configura
		var new_sprite := Sprite2D.new()
		photo_frame.view_port.add_child(new_sprite)
		new_sprite.texture = PortraitsPaths.flarya_1
		new_sprite.centered = false
		new_sprite.scale = Vector2(0.3, 0.3)


func command_atribute_decisions(command: String):
	# cambios de atributos en command deben de seguir una sintaxis exacta
	# ejemplo: "flarya interes - 1" ==  (furry_name) (atribute) (operator) (value)
	var text: String = command
	var split_text: Array = text.split(" ")
	var furry_name: String = split_text[0]
	var atribute: String = split_text[1]
	var operator: String = split_text[2]
	var value: int = split_text[3] as int
	match furry_name:
		"flarya":
			if atribute == "interes":
				if operator == "+":
					PlayerStats.player_stats["flarya"]["interes"] += value
					print(PlayerStats.player_stats["flarya"]["interes"])
				elif operator == "-":
					PlayerStats.player_stats["flarya"]["interes"] -= value
					print(PlayerStats.player_stats["flarya"]["interes"])
		_:
			pass
