extends Control

var order_panel = preload("res://order_panel.tscn")
var container_list:Array


# Called when the node enters the scene tree for the first time.
func _ready():
	order_panel = preload("res://order_panel.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var panel:OrderPanel = order_panel.instantiate()
	$FlowContainer.add_child(panel)
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
