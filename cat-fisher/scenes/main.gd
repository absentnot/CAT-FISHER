extends Node2D

@export var cats: PackedScene
var current_cat: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$fishing_bar.connect("caught_cat", cat_caught)
	new_cat()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cat_caught():
	if current_cat.health <= 0:
		print("GOTCAUGHT-LAUNCHING")
		current_cat.launch_cat()
		new_cat()
	else:
		print("REEL IN")
		print(current_cat.global_position)
		current_cat.health -= 1
		current_cat.reel_in()
		$fishing_bar.rarity = 100 - current_cat.rarity - current_cat.health * 2
		

func new_cat():
	print("NEW CAT")
	var child = cats.instantiate()
	current_cat = child
	current_cat.global_position = $player.global_position + Vector2(165.0, 300.0)
	add_child(child)
	
	$fishing_bar.rarity = 100 - current_cat.rarity - current_cat.health * 2
