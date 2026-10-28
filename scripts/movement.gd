extends CharacterBody2D

var direction := Vector2.ZERO
var weapon_direction : float
@export var speed := 500
@export var swing_speed := 1.0

func _physics_process(delta):
	direction = Input.get_vector("left","right","up","down")
	velocity = direction * delta * speed * 100
	move_and_slide()
	
	if Input.get_vector("weapon_left","weapon_right","weapon_up","weapon_down") != Vector2.ZERO:
		weapon_direction = Input.get_vector("weapon_left","weapon_right","weapon_up","weapon_down").angle() + PI/2
	var diff = fmod(weapon_direction - $Sword.rotation,2*PI)
	if diff > PI : diff -= 2*PI
	$Sword.rotation += diff * swing_speed
	#$Sword.move_and_slide()
	
	
	if Input.is_action_just_pressed("b"):
		var file:Dictionary = JSON.parse_string(FileAccess.open("user://saves/save1.json", FileAccess.READ).get_as_text())
		position = Vector2(file["pos"]["x"],file["pos"]["y"])
	if Input.is_action_just_pressed("x"):
		DirAccess.make_dir_recursive_absolute("user://saves")
		var data := {}
		data["pos"] = {"x": position.x,"y": position.y}
		var file := FileAccess.open("user://saves/save1.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(data, "\t"))
		file.close()
	
	
	if Input.is_action_just_pressed("a"):
		if $Camera.top_level == false:
			$Camera.top_level = true
		else:
			$Camera.top_level = false
	
	if $Camera.top_level == true:
		$Camera.zoom = Vector2(0.3,0.3)
	else:
		$Camera.zoom = Vector2.ONE
