class_name SaveSystem
extends Node


const SAVE_PATH: String = "user://game_save_file.save"
var game_save_file: Dictionary = {
	"save_1": PlayerStats._player_stats,
	
	"save_2": {},
	"save_3": {}
}


func save_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	file.store_var(game_save_file)
	print("game saved")


func load_game() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		game_save_file = file.get_var()
		PlayerStats._player_stats = game_save_file["save_1"]
		print("game loaded")

