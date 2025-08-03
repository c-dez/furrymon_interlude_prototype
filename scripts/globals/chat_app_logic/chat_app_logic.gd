extends Node

# global
# se hace cargo de ejecutar acciones segun el command de json
func _on_command_atribute_signal(command: String):
	command_atribute_decisions(command)


func command_atribute_decisions(command: String):
	# cambios de atributos en command deben de seguir una sintaxis exacta
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
