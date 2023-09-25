extends CharacterBody2D

var Acceleration = 250
var Friction = 250
var MaxSpeed = 80

var Velocity = Vector2.ZERO

func _process(delta):
	GetInput(delta)
	
func _physics_process(delta):
	move_and_collide(Velocity * delta)

func GetInput(delta):
	var MoveInput = Vector2.ZERO
	
	MoveInput.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	MoveInput.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if MoveInput != Vector2.ZERO:
		Velocity = Velocity.move_toward(MoveInput * MaxSpeed, (Acceleration * delta))
		print(Velocity)
	else:
		Velocity = Velocity.move_toward(Vector2.ZERO, (Friction * delta))
