class_name ToGoBox
extends Platform
# Called when the node enters the scene tree for the first time.
func _ready():
	
	capacity = 6
	tag = ETag.ToGoBox
	type_id = ETypeId.itemInteractable
	
	positions.append($Marker2D.global_position)
	positions.append($Marker2D2.global_position)
	positions.append($Marker2D3.global_position)
	positions.append($Marker2D4.global_position)
	positions.append($Marker2D5.global_position)
	positions.append($Marker2D6.global_position)
	
	positions_occupation.append(false)
	positions_occupation.append(false)
	positions_occupation.append(false)
	positions_occupation.append(false)
	positions_occupation.append(false)
	positions_occupation.append(false)


func _process(delta):
	pass
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
	item.SCALE = Vector2(.5, .5)
	item.is_partially_removed = false
	var tween = item.get_tree().create_tween()
	contains.append(item)
	item.containerPos = find_open_position()
	tween.tween_property(item, "position", positions[item.containerPos], 0.2).set_ease(Tween.EASE_OUT)
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

		item.SCALE = Vector2(1.0, 1.0)

func full_remove(item):
	if contains.find(item) != -1:
		positions_occupation[item.containerPos] = false
		item.containerPos = -1
		item.is_partially_removed = false
		contains.erase(item)
	
func find_open_position() -> int:
	for i in positions.size():
		if positions_occupation.size() == 1:
			positions_occupation[0] == true
			return 0
		elif positions_occupation[i] == false:
			positions_occupation[i] = true
			return i
	return -1


func _on_bell_sell_donuts():
	var parent:MainScene = get_parent()
	for d:Donut in contains:
		match d.donut_status:
			Global.DONUT_STATUS.RAW:
				Global.score += 0
			Global.DONUT_STATUS.ALMOST_DONE:
				Global.score += 5
			Global.DONUT_STATUS.DONE:
				Global.score += 10
			Global.DONUT_STATUS.BURNED:
				Global.score += 3
	parent.to_be_removed.append_array(contains)
	contains.clear()
	for i in range(positions_occupation.size()):
		positions_occupation[i] = false
		
