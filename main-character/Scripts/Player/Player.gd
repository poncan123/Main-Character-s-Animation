extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D


@export var speed = 300.0
@export var jump_height = -550.0

@export var attacking = false

func _process(delta):
	if Input.is_action_just_pressed("Attack"):
		attack()

func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x) 
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_height

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	update_animation()
	move_and_slide()
	
func attack():
	attacking = true
	animation.play("Attack")
	
func update_animation():
	if !attacking:
		if velocity.x !=0:
			animation.play("Run")
		else:
			animation.play("Idle")
			
		if velocity.y < 0:
			animation.play("Jump")
