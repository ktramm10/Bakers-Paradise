class_name Oven

extends Platform


# Called when the node enters the scene tree for the first time.
func _ready():
	tag = ETag.oven
	capacity = 6
	SCALE = Vector2(2.0, 2.0)
	positions.append($Marker2D.global_position)
	positions.append($Marker2D2.global_position)
	positions.append($Marker2D3.global_position)
	positions.append($Marker2D4.global_position)
	positions.append($Marker2D5.global_position)
	positions.append($Marker2D6.global_position)
	

	for x in range(capacity + 1):
		positions_occupation.append(false)
	
func _process(delta):
	pass

# TODO: Implement Overrides
func idle():
	scale = SCALE
	
func hovered():
	scale = SCALE * 1.02
	
func placed(item:Donut):
	$AudioStreamPlayer.play()
	item.is_partially_removed == false
	item.scale = item.SCALE * 0.5
	print("oven_placed")
	var tween = item.get_tree().create_tween()
	contains.append(item)
	item.containerPos = find_open_position()
	item.get_timer().set_paused(false)
	item.get_timer().start()
	tween.tween_property(item, "position", positions[item.containerPos], 0.2).set_ease(Tween.EASE_OUT)	
	idle()

func returned(item:Donut):
	var tween = item.get_tree().create_tween()
	tween.tween_property(item, "global_position", item.initialPos, 0.2).set_ease(Tween.EASE_OUT)	
	item.is_partially_removed = false
	item.scale = item.SCALE * .5
	if item.temp_body_ref:
		if item.temp_body_ref.tag == ETag.oven:
			item.get_timer().set_paused(false)
	idle()

func partial_remove(item:Donut): 
	print("item attempted to partial")
	if contains.find(item) != -1:
		print("item partial'd")
		item.is_partially_removed = true
		item.scale = item.SCALE
		item.get_timer().set_paused(true)
	
func full_remove(item:Donut):
	print("full removal")
	if contains.find(item) != -1:
		positions_occupation[item.containerPos] = false
		item.containerPos = -1
		item.is_partially_removed = false

		contains.erase(item)

		
func find_open_position() -> int:
	for i in positions_occupation.size():
		if positions_occupation.size() == 1:
			positions_occupation[0] == true
			return 0
		elif positions_occupation[i] == false:
			positions_occupation[i] = true
			return i
	return -1
			

