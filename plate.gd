class_name Plate

extends Platform

var plate_positions:Array
var plate_positions_occupation:Array
# Called when the node enters the scene tree for the first time.
func _ready():
	
	super._ready()
	tag = ETag.plate
	capacity = 3
	
	
	plate_positions.append(Vector2(position.x - 50 * scale.x, position.y + 20 * scale.y))
	plate_positions.append(Vector2(position.x,      position.y + 20 * scale.y))
	plate_positions.append(Vector2(position.x + 50 * scale.x, position.y + 20 * scale.y))
	plate_positions_occupation.append(false)
	plate_positions_occupation.append(false)
	plate_positions_occupation.append(false)
	
# TODO: Implement Overrides

func idle():
	scale = Vector2(.5, .5)
	
func hovered():
	scale = Vector2(.55 ,.55)
	
	
func placed(item:Donut):
	if item != Global.item_being_moved:
		return
	item.is_partially_removed == false
	var tween = item.get_tree().create_tween()
	contains.append(item)
	item.containerPos = find_open_position()
	tween.tween_property(item, "position", plate_positions[item.containerPos], 0.2).set_ease(Tween.EASE_OUT)
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
		plate_positions_occupation[item.containerPos] = false
		item.containerPos = -1
		item.is_partially_removed = false
		contains.erase(item)
	
func find_open_position() -> int:
	for i in plate_positions_occupation.size():
		if plate_positions_occupation.size() == 1:
			plate_positions_occupation[0] == true
			return 0
		elif plate_positions_occupation[i] == false:
			plate_positions_occupation[i] = true
			return i
	return -1