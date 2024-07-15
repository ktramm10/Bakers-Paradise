class_name ToGoBox
extends Platform

var tgb_positions:Array
var tgb_positions_occupation:Array
# Called when the node enters the scene tree for the first time.
func _ready():
	capacity = 6
	tag = ETag.ToGoBox
	type_id = ETypeId.itemInteractable
	
	tgb_positions.append($Marker2D.global_position)
	tgb_positions.append($Marker2D2.global_position)
	tgb_positions.append($Marker2D3.global_position)
	tgb_positions.append($Marker2D4.global_position)
	tgb_positions.append($Marker2D5.global_position)
	tgb_positions.append($Marker2D6.global_position)
	
	tgb_positions_occupation.append(false)
	tgb_positions_occupation.append(false)
	tgb_positions_occupation.append(false)
	tgb_positions_occupation.append(false)
	tgb_positions_occupation.append(false)
	tgb_positions_occupation.append(false)
	
	
	


func _process(delta):
	for d:Donut in contains:
		if !d.is_partially_removed:
			d.scale = Vector2(.6, .6)
			d.draggable = false
# TODO: Implement Overrides

func idle():
	print("called")
	scale = Vector2(1, 1)
	
func hovered():
	print("called")
	scale = Vector2(1.05 ,1.05)
	
func placed(item:Donut):
	if item != Global.item_being_moved:
		return
	item.is_partially_removed == false
	var tween = item.get_tree().create_tween()
	contains.append(item)
	item.containerPos = find_open_position()
	tween.tween_property(item, "position", tgb_positions[item.containerPos], 0.2).set_ease(Tween.EASE_OUT)
	if not item.get_timer().is_paused():
		item.get_timer().set_paused(true)

			
func returned(item):
	var tween = item.get_tree().create_tween()
	tween.tween_property(item, "global_position", item.initialPos, 0.2).set_ease(Tween.EASE_OUT)	
	item.is_partially_removed = false
	if item.temp_body_ref.tag == ETag.oven:
		item.get_timer().set_paused(false)
	
func partial_remove(item:Donut):
	if contains.find(item) != -1:
		item.is_partially_removed = true

		item.scale = Vector2(1, 1)

func full_remove(item):
	if contains.find(item) != -1:
		tgb_positions_occupation[item.containerPos] = false
		item.containerPos = -1
		item.is_partially_removed = false
		contains.erase(item)
	
func find_open_position() -> int:
	for i in tgb_positions.size():
		if tgb_positions_occupation.size() == 1:
			tgb_positions_occupation[0] == true
			return 0
		elif tgb_positions_occupation[i] == false:
			tgb_positions_occupation[i] = true
			return i
	return -1
