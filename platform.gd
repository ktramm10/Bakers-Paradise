class_name Platform
extends StaticBody2D

enum ETag { trashCan, oven, plate, donutOMatic,ToGoBox}
enum ETypeId { mouseInteractable, itemInteractable}


var tag:ETag
var type_id:ETypeId

var contains:Array
var capacity

# Called when the node enters the scene tree for the first time.
func _ready():
	capacity = 0
	type_id = ETypeId.itemInteractable

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func partial_remove(_item):
	pass
	
func full_remove(_item):
	pass
	
func _process(delta):
	pass

func idle():
	pass
	
func hovered():
	pass
	
func placed(_item):
	pass
	
func returned(_item):
	pass
