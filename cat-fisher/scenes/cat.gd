extends CharacterBody2D

var gravity = 9.0
var launch_speed = 350.0
var launched = false
var sleeping = false

var rarity = 20
var health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var randscale = randf_range(0.5, 1.0)
	scale = Vector2(randscale, randscale)
	randscale = randf_range(0.65, 1.2)
	launch_speed *= randscale
	randomize_cat_type()

func randomize_cat_type():
	rarity = randi_range(35, 90)
	health = rarity % 10
	modulate = Color(randf(), randf(), randf())
	if randf() <= 0.9:
		$Cat.material = null
		$"Lying-cat".material = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if launched:
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			velocity /= 1.5
			$Cat.visible = false
			$"Lying-cat".visible = true
			stop_dripping()
			
		move_and_slide()
		sleeping = true
		
func reel_in():
	var tw = create_tween()
	tw.tween_property(self, "global_position", global_position - Vector2(0, 300.0/(rarity%10)) - Vector2(0, 10.0), 0.1)
	tw.tween_property(self, "global_position", global_position - Vector2(0, 300.0/(rarity%10)) + Vector2(0, 5.0), 0.1)
	tw.tween_property(self, "global_position", global_position - Vector2(0, 300.0/(rarity%10)), 0.1)

func launch_cat():
	if !sleeping:
		print("LAUNCHING")
		launched = true
		velocity = Vector2(-1, -2) * launch_speed
		

func stop_dripping():
	$GPUParticles2D.emitting = false
