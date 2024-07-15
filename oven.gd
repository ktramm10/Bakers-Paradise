class_name Oven

extends Platform

var oven_positions:Array
var oven_positions_occupation:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	tag = ETag.oven
	capacity = 3
	
	oven_positions.append($Marker2D.global_position)
	oven_positions.append($Marker2D2.global_position)
	oven_positions.append($Marker2D3.global_position)

	for x in range(capacity + 1):
		oven_positions_occupation.append(false)
	
func _process(delta):
	for d:Donut in contains:
		if !d.is_partially_removed:
			d.scale = Vector2(.6, .6)

# TODO: Implement Overrides

func idle():
	scale = Vector2(1, 1)
	
func hovered():
	scale = Vector2(1.05 ,1.05)
	
func placed(item:Donut):
	item.is_partially_removed == false
	print("oven_placed")
	var tween = item.get_tree().create_tween()
	contains.append(item)
	item.containerPos = find_open_position()
	item.get_timer().set_paused(false)
	item.get_timer().start()
	tween.tween_property(item, "position", oven_positions[item.containerPos], 0.2).set_ease(Tween.EASE_OUT)	
	idle()

func returned(item:Donut):
	var tween = item.get_tree().create_tween()
	tween.tween_property(item, "global_position", item.initialPos, 0.2).set_ease(Tween.EASE_OUT)	
	item.is_partially_removed = false
	if item.temp_body_ref:
		if item.temp_body_ref.tag == ETag.oven:
			item.get_timer().set_paused(false)
	idle()

func partial_remove(item:Donut): 
	print("item attempted to partial")
	if contains.find(item) != -1:
		print("item partial'd")
		item.is_partially_removed = true

		item.scale = Vector2(1, 1)
		item.get_timer().set_paused(true)
	
func full_remove(item:Donut):
	print("full removal")
	if contains.find(item) != -1:
		oven_positions_occupation[item.containerPos] = false
		item.containerPos = -1
		item.is_partially_removed = false

		contains.erase(item)

		
func find_open_position() -> int:
	for i in oven_positions_occupation.size():
		if oven_positions_occupation.size() == 1:
			oven_positions_occupation[0] == true
			return 0
		elif oven_positions_occupation[i] == false:
			oven_positions_occupation[i] = true
			return i
	return -1
			

