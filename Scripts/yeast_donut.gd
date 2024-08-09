extends Donut


# Called when the node enters the scene tree for the first time.
func _ready():
	SCALE = Vector2(1.5, 1.5)
	super._ready()

func update_donut_texture():
	if not is_powdered:
			if (donut_status == Global.DONUT_STATUS.ALMOST_DONE):
				$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_ALMOST_DONE.png")
			elif (donut_status == Global.DONUT_STATUS.DONE):
				$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_DONE.png")
				donut_type = Global.EOrder_Type.YEAST_DONUT_STD
			elif (donut_status == Global.DONUT_STATUS.BURNED):
				$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_BURNT.png")
			elif (donut_status == Global.DONUT_STATUS.RAW):
				$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_RAW.png")
	else:
				if donut_status == Global.DONUT_STATUS.RAW:
					match powder_status:
						Global.DONUT_MOD_STATUS.BAD:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Raw/Yeast_Donut_RAW_POW_BAD.png")
						Global.DONUT_MOD_STATUS.OKAY:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Raw/Yeast_Donut_RAW_POW_OKAY.png")
						Global.DONUT_MOD_STATUS.GOOD:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Raw/Yeast_Donut_RAW_POW_GOOD.png")
						Global.DONUT_MOD_STATUS.PERFECT:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Raw/Yeast_Donut_RAW_POW_PERFECT.png")
				elif donut_status == Global.DONUT_STATUS.ALMOST_DONE:
					match powder_status:
						Global.DONUT_MOD_STATUS.BAD:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Almost_Done/Yeast_Donut_ALMOST_DONE_POW_BAD.png")
						Global.DONUT_MOD_STATUS.OKAY:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Almost_Done/Yeast_Donut_ALMOST_DONE_POW_OKAY.png")
						Global.DONUT_MOD_STATUS.GOOD:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Almost_Done/Yeast_Donut_ALMOST_DONE_POW_GOOD.png")
						Global.DONUT_MOD_STATUS.PERFECT:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Almost_Done/Yeast_Donut_ALMOST_DONE_POW_PERFECT.png")
				elif donut_status == Global.DONUT_STATUS.DONE:
					donut_type = Global.EOrder_Type.YEAST_DONUT_POW
					match powder_status:
						Global.DONUT_MOD_STATUS.BAD:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Done/Yeast_Donut_DONE_POW_BAD.png")
						Global.DONUT_MOD_STATUS.OKAY:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Done/Yeast_Donut_DONE_POW_OKAY.png")
						Global.DONUT_MOD_STATUS.GOOD:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Done/Yeast_Donut_DONE_POW_GOOD.png")
						Global.DONUT_MOD_STATUS.PERFECT:
							$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Powdered/Done/Yeast_Donut_DONE_POW_PERFECT.png")
				elif donut_status == Global.DONUT_STATUS.BURNED:
					$Sprite2D.texture = preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_BURNT.png")
	
