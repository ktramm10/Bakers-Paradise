extends Platform

signal trashed(item:Donut)

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	tag = ETag.trashCan
	capacity = 1000
	

# TODO: Implement Overrides

func idle():
	$Sprite2D.texture = preload("res://Art/Trash_Can/Trash_Can_Closed_V1.png")
	
func hovered():
	print("HOVERED TRASH CAN")
	$Sprite2D.texture = preload("res://Art/Trash_Can/Trash_Can_Open_V1.png")
	
	
func placed(item):
	var tween = get_tree().create_tween()
	hovered()
	tween.tween_property(item, "global_position", global_position, 0.2).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.2).timeout
	emit_signal("trashed", item)
	idle()
	
func removed(item):
	pass
