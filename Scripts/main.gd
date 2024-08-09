
class_name MainScene
extends Node
var donuts:Array
var to_be_removed:Array
var to_be_added:Array

signal handoff_selection_data(selection)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in get_children():
		if i.is_in_group("spawning_box"):
			i.spawning_donut.connect(_on_donut_crate_spawning_donut)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if to_be_removed.size() > 0:
		for d in to_be_removed:
			to_be_removed.erase(d)
			donuts.erase(d)
			d.queue_free()
	if to_be_added.size() > 0:
		for d in to_be_added:
			donuts.append(d)
			to_be_added.erase(d)
	if Global.item_being_moved != null:
		for d:Donut in donuts:
			if d.draggable:
				if d != Global.item_being_moved:
						d.draggable = false
						
func _on_trashed(item:Donut):
	to_be_removed.append(item)
	
func _on_donut_has_no_home(item:Donut):
	item.body_ref = get_node("Trash_Can")
	
func _on_quicktime_data_recieved(selection):
	pass
	
func _on_donut_crate_spawning_donut(item):
	call_deferred("add_child", item)
	item.body_ref = get_node("Trash_Can")
	item.donut_has_no_home.connect(_on_donut_has_no_home)
	to_be_added.append(item)
	


func _on_hud_tree_exited():
	Global.save_game()
