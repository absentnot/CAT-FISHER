extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var fishing_bar : PackedScene

var trowing = true
var fishing = false
var catching = false
var cats = ["water_cat","salmon_cat","coral_cat"]
var bar
var bonus = 0

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func  _process(delta: float) -> void:
	if trowing:
		if $Timer.is_stopped():$Timer.start()
		if Input.is_action_just_pressed("click"):
			bonus += 1
	#if !fishing and !catching:

func spawn(p):
	bar = fishing_bar.instantiate()
	add_child(bar)
	bar.global_position = p
	catching = true
	var n = randf_range(10,25)
	bar.rarity = n

func generate_Random_cat():
	return cats[randi_range(0,2)]

func _on_timer_timeout() -> void:
	print(bonus)
	trowing = false
	var point_position = Vector2(global_position.x+(bonus*2),global_position.y) 
	$Line2D.add_point($a.global_position)
	$Line2D.add_point(point_position)
