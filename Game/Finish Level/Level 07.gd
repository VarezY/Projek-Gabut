extends Level

var Signs
onready var Stop = $Node2D/Stop/CollisionPolygon2D

func _ready():
	Signs = get_tree().get_nodes_in_group("Sign")
	for S in Signs:
		S.connect("pressed", self, "_on_Button_pressed", [S.PenjelasanRambu, S.get_normal_texture()])
	
	var Lampu = get_tree().get_nodes_in_group("LampuLL")
	for L in Lampu:
		L.play()
	
func _on_GUI_ButtonCarGo():
	Stop.disabled = true
	SFX.StartEngine()
	Andy.start = 0
	Andy.rem = false


func _on_GUI_ButtonCarStop():
	Stop.disabled = false
	SFX.StopEngine()
	Andy.rem = true


func _on_GUI_CircleLoad():
	pass # Replace with function body.

func _on_Button_pressed(penjelasan, textur):
	$GUI/Layout/Sign/HBoxContainer/Label.set_text(penjelasan)
	showLayout()
	$GUI/Layout/Sign.visible = true
	$GUI/Layout/Sign/AnimationPlayer.play("Up")
	get_tree().paused = true
	showcase.set_texture(textur)


func _on_Danger_Pelanggaran():
	Points -= 1


func _on_Lampu3_frame_changed():
	if $Node2D/Lampu3.get_frame() < 6:
		$Node2D/Danger/CollisionPolygon2D.disabled = true
		$Node2D/Danger/CollisionPolygon2D2.disabled = false
	else:
		$Node2D/Danger/CollisionPolygon2D.disabled = false
		$Node2D/Danger/CollisionPolygon2D2.disabled = true


func _on_Stop_body_entered(body):
	if body.name == "AndyCar":
		Points -= 1
		$Node2D/Stop/CollisionPolygon2D.disabled = true
