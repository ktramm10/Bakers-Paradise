class_name PowderStation

extends Platform

@export var hud_ref:HUD

func _ready():
	hud_ref.send_quick_time_data.connect(_on_quicktime_data_recieved)
	
	tag = ETag.plate
	capacity = 3
	
	SCALE = Vector2(1.0, 1.0)
	
	positions.append(Vector2($Marker2D.global_position))
	positions.append(Vector2($Marker2D2.global_position))
	positions.append(Vector2($Marker2D3.global_position))
	positions_occupation.append(false)
	positions_occupation.append(false)
	positions_occupation.append(false)
	
func _process(delta):
	if contains:
		for d:Donut in contains:
			if d.is_powdered:
				$Button.visible = false
				return
		$Button.visible = true
	else:
		$Button.visible = false
	

func idle():
	scale = SCALE
	
func hovered():
	scale = SCALE * 1.05
	
	
func placed(item:Donut):
	$AudioStreamPlayer.play()
	if item != Global.item_being_moved:
		return
	item.scale = item.SCALE * 0.5
	item.is_partially_removed == false
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
	item.scale = item.SCALE * .5
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
	for i in positions_occupation.size():
		if positions_occupation.size() == 1:
			positions_occupation[0] == true
			return 0
		elif positions_occupation[i] == false:
			positions_occupation[i] = true
			return i
	return -1




func _on_button_pressed():
	hud_ref.toggle_quicktime_visibility()
	
func _on_quicktime_data_recieved(selection):
	print("Called")
	for d:Donut in contains:
		print(d)
		d.is_powdered = true
		match selection:
			0:
				d.powder_status = Global.DONUT_MOD_STATUS.PERFECT
			1: 
				d.powder_status = Global.DONUT_MOD_STATUS.GOOD
			2:
				d.powder_status = Global.DONUT_MOD_STATUS.OKAY
			3: 
				d.powder_status = Global.DONUT_MOD_STATUS.BAD
	$Button.visible = false

