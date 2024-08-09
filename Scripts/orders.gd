class_name Orders

extends Control

var order_panel = preload("res://order_panel.tscn")
var container_list:Array
var order_limit = 4


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if container_list.is_empty():
		add_new_order()
		

func add_new_order():
	$Order_Ping.play()
	var panel:OrderPanel = order_panel.instantiate()
	$OrderContainer.add_child(panel)
	container_list.append(panel)

func get_item_by_tag(tag) -> OrderPanel:
	for i:OrderPanel in container_list:
		if i.tag == tag:
			return i
	return null

func contains_item_with_tag(tag) -> bool:
	for i:OrderPanel in container_list:
		if i.tag == tag:
			return true
	return false
