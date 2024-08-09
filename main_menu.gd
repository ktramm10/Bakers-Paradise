extends Control

@export var main_scene:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_game()
	$"High Score".text = str("High Score: ", Global.high_score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("HIGH SCORE GLOBAL VAL: ", Global.high_score)
	pass


func _on_start_pressed():
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	get_tree().change_scene_to_packed(main_scene)


func _on_quit_pressed():
	$AudioStreamPlayer.play()
	get_tree().quit()

