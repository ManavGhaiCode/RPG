extends CharacterBody2D

var Acceleration = 250
var Friction = 250
var MaxSpeed = 30

var Velocity = Vector2.ZERO
var MoveInput = Vector2.ZERO
var anim = null

var Dir = Vector2.ZERO

func _ready():
	anim = $AnimationPlayer

func _process(delta):
	GetInput(delta)
	Animator()
	
func _physics_process(delta):
	move_and_collide(Velocity * delta)

func Animator():
	if MoveInput.x > 0:
		anim.play("RunRight")
		Dir.x = 1
		Dir.y = 0
	elif MoveInput.x < 0:
		anim.play("RunLeft")
		Dir.x = -1
		Dir.y = 0
	elif MoveInput.y > 0:
		anim.play("RunDown")
		Dir.y = 1
		Dir.x = 0
	elif MoveInput.y < 0:
		anim.play("RunUp")
		Dir.y = -1
		Dir.x = 0
	else:
		if Dir.x == 1 && Dir.y == 0:
			anim.play("IdleRight")
		elif Dir.x == -1 && Dir.y == 0:
			anim.play("IdleLeft")
		elif Dir.y == 1:
			anim.play("IdleDown")
		elif Dir.y == -1:
			anim.play("IdleUp")

func GetInput(delta):
	MoveInput = Vector2.ZERO
	MoveInput.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if MoveInput.x == 0:
		MoveInput.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if MoveInput != Vector2.ZERO:
		Velocity = Velocity.move_toward(MoveInput * MaxSpeed, (Acceleration * delta))
	else:
		Velocity = Velocity.move_toward(Vector2.ZERO, (Friction * delta))
