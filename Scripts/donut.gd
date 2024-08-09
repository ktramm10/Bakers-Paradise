
class_name Donut
extends Interactable

signal donut_placed
signal donut_has_no_home(item:Donut)

var donut_type = -1
var is_powdered = false
var draggable = false
var is_inside_droppable = false
var body_ref: Platform
var offset: Vector2
var initialPos: Vector2
var donut_status = Global.DONUT_STATUS.RAW
var powder_status
var SCALE = Vector2(2.0, 2.0)
var temp_body_ref: Platform = null
var containerPos:int
var is_partially_removed



func _ready():
	is_partially_removed = false
	scale = SCALE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_donut_texture()
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.item_being_moved = self
			Global.is_dragging = true

		if Input.is_action_pressed("click") && Global.item_being_moved == self:
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click") && Global.item_being_moved == self:
			Global.is_dragging = false
			if is_inside_droppable && body_ref.contains.size() < body_ref.capacity:
				on_donut_placed(body_ref)
			elif temp_body_ref == null:
				body_ref = null
				no_home_for_donut()
			else:
				on_donut_placed(temp_body_ref)


func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(scale.x + .05, scale.y + .05)


func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		draggable = false
		scale = Vector2(scale.x - .05, scale.y - .05)

func _on_area_2d_body_entered(body:Platform):
	if body.is_in_group("dropable"):
		is_inside_droppable = true
		body.hovered()
		body_ref = body


func _on_area_2d_body_exited(body:Platform):
	if body.is_in_group("dropable"):
		is_inside_droppable = false
		body.idle()
		if body_ref == body:
			body_ref = null
		if body.contains.find(self) != -1:
			body.partial_remove(self)


func _on_cook_timer_timeout():
	if donut_status != Global.DONUT_STATUS.BURNED:
		donut_status += 1
		if donut_status == Global.DONUT_STATUS.DONE:
			$Donut_Complete.play()
		
	
	
func on_donut_placed(body:Platform):
	if temp_body_ref == null && body_ref.contains.size() < body_ref.capacity: # Handles donuts inital placement
		body.placed(self)
		Global.item_being_moved = null
		temp_body_ref = body_ref

	elif temp_body_ref != body: #Handles donut movement from platform to platform	
		if body.contains.size() != body.capacity: # successfully placed on new platform
			temp_body_ref.full_remove(self)
			body.placed(self)
			Global.item_being_moved = null
			temp_body_ref = body_ref
		else: # returned to previous platform
			body.returned(self)
			Global.item_being_moved = null
	else: 
		body.returned(self)
		Global.item_being_moved = null

func update_donut_texture():
	pass

func get_timer() -> Timer:
	return $CookTimer
	
func no_home_for_donut():
	emit_signal("donut_has_no_home", self)
	body_ref.placed(self)
	
