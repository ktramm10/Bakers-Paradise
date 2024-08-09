extends Node2D

var is_dragging = false
var item_being_moved:Donut
var score = 0
var high_score = 0

enum DONUT_STATUS { RAW = 1, ALMOST_DONE, DONE, BURNED}

enum DONUT_MOD_STATUS {PERFECT, GOOD, OKAY, BAD}

enum EOrder_Type {DONUT_HOLE_STD, DONUT_HOLE_POW, YEAST_DONUT_STD, YEAST_DONUT_POW}

const TEXTURE_LIST = [
	preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_DONE.png"),
	preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_DONE_POWDERED_PERFECT.png"),
	preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_DONE.png"),
	preload("res://Art/Donuts/Yeast_Donut/Powdered/Done/Yeast_Donut_DONE_POW_PERFECT.png")]

func save() -> Dictionary:
	var save_dict = {
		"high_score" : high_score
	}
	return save_dict

func save_game():
	var save_file = FileAccess.open("res://savegame.txt", FileAccess.WRITE)
	var save_data = Global.save()
	var json_string = JSON.stringify(save_data)
	
	save_file.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("res://savegame.txt"):
		return
	print("file exists")
	var save_file = FileAccess.open("res://savegame.txt", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		print(json_string)
		var json = JSON.new()
	
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at ",
			json.get_error_line())
			continue
		
		print("no parse error")
		var save_data = json.get_data()
		
		for i in save_data.keys():
			if i == "high_score":
				print("successful if statement")
				Global.set(i, save_data[i])
				print("Key: ", i, "\n", "Value: ", save_data[i])
