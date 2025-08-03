extends Node


func _on_command_recived(command:String):
	command_decisions(command)


func command_decisions(command:String):
	match command:
		"flarya int +1":
			print("yeah")
			pass
		"flarya int +2":
			print("2")
		_:
			pass