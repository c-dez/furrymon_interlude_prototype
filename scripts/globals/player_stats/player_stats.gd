extends Node
# global


var player_stats: Dictionary = {
	"player_name": "Default Name",
	"player_id": "Player",
	
	"flarya": {
		"interes": 0,
	}
}

func set_atribute(value: int, furry_name: String, atribute_name: String) -> void:
	player_stats[furry_name][atribute_name] += max(value, 0)


func get_atribute(furry_name: String, atribute_name: String) -> int:
	return player_stats[furry_name][atribute_name]

func get_player_id() -> String:
	return player_stats["player_id"]