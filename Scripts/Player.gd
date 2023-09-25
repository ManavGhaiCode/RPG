extends CharacterBody2D

var Acceleration = 250
var Friction = 250
var MaxSpeed = 30

var Velocity = Vector2.ZERO
var MoveInput = Vector2.ZERO
var anim = null

var Dir = "Right"
var state = 0

func _ready():
	anim = $AnimationPlayer

func _process(delta):
	GetInput(delta)
	Animator()
	
func _physics_process(delta):
	move_and_collide(Velocity * delta)

func Animator():
	if MoveInput.x > 0:
		Dir = "Right"
	elif MoveInput.x < 0:
		Dir = "Left"
	elif MoveInput.y < 0:
		Dir = "Up"
	elif MoveInput.y > 0:
		Dir = "Down"
	
	if MoveInput != Vector2.ZERO:
		anim.play("Run" + Dir)
	else:
		anim.play("Idle" + Dir)

func GetInput(delta):
	MoveInput = Vector2.ZERO
	MoveInput.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if MoveInput.x == 0:
		MoveInput.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if MoveInput != Vector2.ZERO:
		Velocity = Velocity.move_toward(MoveInput * MaxSpeed, (Acceleration * delta))
	else:
		Velocity = Velocity.move_toward(Vector2.ZERO, (Friction * delta))
