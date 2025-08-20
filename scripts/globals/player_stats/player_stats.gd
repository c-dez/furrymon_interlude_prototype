extends Node
# global

## almacena la informacion y stats de jugador, es privado solo se accede directamente para save game, para lo demas se usan get/set
var _player_stats: Dictionary = {
	"player_name": "Default Name",
	"player_id": "Player",
	
	"flarya": {
		"interes": 0,
		"algun_otro_stat": 0,
	},
	"algun_otro_furry": {
		"interes": 0,
		"example_stat": 0,
	},
}

func set_atribute(value: int, furry_name: String, atribute_name: String) -> void:
	_player_stats[furry_name][atribute_name] += max(value, 0)


func get_atribute(furry_name: String, atribute_name: String) -> int:
	return _player_stats[furry_name][atribute_name]


func get_player_id() -> String:
	return _player_stats["player_id"]
