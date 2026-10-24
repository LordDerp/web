extends Node2D

var direction := Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Input.get_vector("left","right","up","down")
	position += direction * delta * 500
