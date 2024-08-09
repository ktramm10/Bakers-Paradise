class_name OrderPanel

extends Control

const D_H_STD_tex = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_DONE.png")
const D_H_POW_tex = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_DONE_POWDERED_PERFECT.png")
const Y_D_STD_tex = preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_DONE.png")
const Y_D_POW_tex = preload("res://Art/Donuts/Yeast_Donut/Powdered/Done/Yeast_Donut_DONE_POW_PERFECT.png")

const panel_display = preload("res://panel_display.tscn")





const NUM_DONUT_OPTIONS = 4
var quantity
var tag_list:Array
var texture_list:Array
var panel_list:Array
var positions_list:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	positions_list.append($Marker2D4.position)
	positions_list.append($Marker2D5.position)
	positions_list.append($Marker2D6.position)
	positions_list.append($Marker2D.position)
	positions_list.append($Marker2D2.position)
	positions_list.append($Marker2D3.position)
	
	generate_order_panel()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func generate_order_panel():
	quantity = randi_range(1, 6)
	for x in range(quantity):
		tag_list.append(Global.EOrder_Type.values().pick_random())
		if !texture_list.has(tag_list[x]):
			texture_list.append(tag_list[x])
			
	var iteration_count = 0
	for t in texture_list:
		var new_panel_display = panel_display.instantiate()
		new_panel_display.create(num_of_unique_occurences(t, tag_list), Global.TEXTURE_LIST[t], positions_list[iteration_count])
		add_child(new_panel_display)
		panel_list.append(new_panel_display)
		iteration_count += 1
		
func num_of_unique_occurences(object, list) -> int:
	var count = 0
	for i in list:
		if i == object:
			count += 1
	print(count)
	return count
	
