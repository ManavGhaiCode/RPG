extends CharacterBody2D

var Acceleration = 100
var Friction = 100
var MaxSpeed: float = 100.00

var Velocity: Vector2 = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	GetInput(delta)
	
func _physics_process(delta):
	move_and_collide(Velocity * delta)

func GetInput(delta):
	var MoveInput = Vector2.ZERO
	
	MoveInput.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	MoveInput.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if MoveInput != Vector2.ZERO:
		Velocity += MoveInput.normalized() * (Acceleration * delta)
		# Velocity = Velocity.clamp()
	else:
		Velocity = Velocity.move_toward(Vector2.ZERO, (Friction * delta))
