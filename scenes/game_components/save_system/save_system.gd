class_name SaveSystem
extends Node


const SAVE_PATH: String = "user://game_save_file.save"
var game_save_file: Dictionary = {
	"save_1": {
	"player_stats": PlayerStats.player_stats,
	},
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
		print("game loaded")
