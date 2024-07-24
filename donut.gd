
class_name Donut
extends Interactable

signal donut_placed
signal donut_has_no_home(item:Donut)
var is_powdered = false
var draggable = false
var is_inside_droppable = false
var body_ref: Platform
var offset: Vector2
var initialPos: Vector2
var donut_status = Global.DONUT_STATUS.RAW
var powder_status
var SCALE = Vector2(1.0, 1.0)
var temp_body_ref: Platform = null
@export var containerPos:int
var is_partially_removed



func _ready():
	is_partially_removed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#TODO on click item being moved set to global variable and us global for other movements to only move one at a time
func _process(_delta):
	update_donut_texture()
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.item_being_moved = self
			Global.is_dragging = true
			print(powder_status)
			print(is_powdered)

		if Input.is_action_pressed("click") && Global.item_being_moved == self:
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click") && Global.item_being_moved == self:
			Global.is_dragging = false
			if is_inside_droppable && body_ref.contains.size() < body_ref.capacity:
				on_donut_placed(body_ref)
			elif temp_body_ref == null:
				print("NO HOME FOR DONUT")
				body_ref == null
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
		scale = SCALE

func _on_area_2d_body_entered(body:Platform):
	if body.is_in_group("dropable"):
		is_inside_droppable = true
		body.hovered()
		body_ref = body


func _on_area_2d_body_exited(body:Platform):
	if body.is_in_group("dropable"):
		print("exited body")
		is_inside_droppable = false
		body.idle()
		if body_ref == body:
			body_ref = null
		if body.contains.find(self) != -1:
			body.partial_remove(self)


func _on_cook_timer_timeout():
	if donut_status != Global.DONUT_STATUS.BURNED:
		donut_status += 1
		
	
	
func on_donut_placed(body:Platform):
	
	if temp_body_ref == null && body_ref.contains.size() < body_ref.capacity: # Handles donuts inital placement
		print("touched thing")
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
	if not is_powdered:
		if (donut_status == Global.DONUT_STATUS.ALMOST_DONE):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_ALMOST_DONE.png")
		elif (donut_status == Global.DONUT_STATUS.DONE):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_DONE.png")
		elif (donut_status == Global.DONUT_STATUS.BURNED):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_BURNT.png")
		elif (donut_status == Global.DONUT_STATUS.RAW):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_RAW.png")
	else:
		if donut_status == Global.DONUT_STATUS.RAW:
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_RAW_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_RAW_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_RAW_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_RAW_POWDERED_PERFECT.png")
		elif donut_status == Global.DONUT_STATUS.ALMOST_DONE:
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_ALMOST_DONE_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_ALMOST_DONE_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_ALMOST_DONE_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_ALMOST_DONE_POWDERED_PERFECT.png")
		elif donut_status == Global.DONUT_STATUS.DONE:
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_DONE_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_DONE_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_DONE_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_DONE_POWDERED_PERFECT.png")
		elif donut_status == Global.DONUT_STATUS.BURNED:
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_BURNT_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_BURNT_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_BURNT_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_BURNT_POWDERED_PERFECT.png")
func get_timer() -> Timer:
	return $CookTimer
	
func no_home_for_donut():
	emit_signal("donut_has_no_home", self)
	body_ref.placed(self)
	
