class_name ToGoBox
extends Platform

@export var hud_ref:HUD

var order_ref:Orders
# Called when the node enters the scene tree for the first time.
func _ready():
	order_ref = hud_ref.get_node("Orders")
	capacity = 6
	tag = ETag.ToGoBox
	type_id = ETypeId.itemInteractable
	
	SCALE = Vector2(1.8, 1.8)
	
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
	scale = SCALE
	
func hovered():
	scale = SCALE * 1.05
	
func placed(item:Donut):
	$AudioStreamPlayer.play()
	if item != Global.item_being_moved:
		return
	item.scale = item.SCALE * .5
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
	item.scale = item.SCALE * .5
	item.is_partially_removed = false
	if item.temp_body_ref.tag == ETag.oven:
		item.get_timer().set_paused(false)
	
func partial_remove(item:Donut):
	if contains.find(item) != -1:
		item.is_partially_removed = true

		item.scale = item.SCALE

func full_remove(item):
	if contains.find(item) != -1:
		positions_occupation[item.containerPos] = false
		item.containerPos = -1
		item.is_partially_removed = false
		contains.erase(item)
	
func find_open_position() -> int:
	for i in positions.size():
		if positions_occupation.size() == 1:
			positions_occupation[0] = true
			return 0
		elif positions_occupation[i] == false:
			positions_occupation[i] = true
			return i
	return -1


func _on_bell_sell_donuts():
	var potential_sell:Array
	var parent:MainScene = get_parent()
	var should_continue
	
	for o:OrderPanel in order_ref.container_list:
		potential_sell.clear()
		print("TOP LOOP")
		if o.tag_list.size() == contains.size():
			print("PASSED SIZE CHECK")
			for d:Donut in contains:
				potential_sell.append(d.donut_type)
			print("POTENTIAL SELL FILLED")
			o.tag_list.sort()
			potential_sell.sort()
			print("SORTED ARRAYS: ", o.tag_list, ", ", potential_sell)
			if o.tag_list == potential_sell:
				scoring(contains)
				parent.to_be_removed.append_array(contains)
				contains.clear()
				positions_occupation.clear()
				for x in range(6):
					positions_occupation.append(false)
				order_ref.container_list.erase(o)
				parent.to_be_removed.append(o)
				$Service_Bell.stream = preload("res://SFX/service_bell.wav")
				$Service_Bell.play()
				return
	$Service_Bell.stream = preload("res://SFX/Wrong sound effect.wav")
	$Service_Bell.play()

func scoring(list):
	for d:Donut in list:
		match d.donut_type:
			Global.EOrder_Type.DONUT_HOLE_STD:
				Global.score += 10
				
			Global.EOrder_Type.DONUT_HOLE_POW:
				match d.powder_status:
					Global.DONUT_MOD_STATUS.PERFECT:
						Global.score += 15
					Global.DONUT_MOD_STATUS.GOOD:
						Global.score += 14
					Global.DONUT_MOD_STATUS.OKAY:
						Global.score += 13
					Global.DONUT_MOD_STATUS.BAD:
						Global.score += 11
						
			Global.EOrder_Type.YEAST_DONUT_STD:
				Global.score += 15
				
			Global.EOrder_Type.YEAST_DONUT_POW:
				match d.powder_status:
					Global.DONUT_MOD_STATUS.PERFECT:
						Global.score += 20
					Global.DONUT_MOD_STATUS.GOOD:
						Global.score += 19
					Global.DONUT_MOD_STATUS.OKAY:
						Global.score += 18
					Global.DONUT_MOD_STATUS.BAD:
						Global.score += 16
