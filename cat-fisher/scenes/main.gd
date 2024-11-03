extends Node2D

@export var cats: PackedScene
@export var text_effect: PackedScene
var current_cat: CharacterBody2D
var cats_caught = 0
var miss_in_a_row = 0

var meows = ["res://assets/meow 1.ogg", "res://assets/meow2.ogg", "res://assets/meow3.ogg", "res://assets/meow4.ogg"]

var game_stopped = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$fishing_bar.connect("caught_cat", cat_caught)
	$fishing_bar.connect("miss", cat_miss)
	$CanvasLayer/RichTextLabel.text = '[center]CATS: '+ str(cats_caught)
	new_cat()
	current_cat.visible = false

func cat_miss():
	if game_stopped:
		return
	if miss_in_a_row > 5:
		spawn_text("MASH!")
	else:
		spawn_text("MISS!")
		miss_in_a_row += 1
	

func cat_caught():
	if game_stopped:
		return
	miss_in_a_row = 0
	if current_cat.health <= 0:
		print("GOTCAUGHT-LAUNCHING")
		cats_caught += 1
		$CanvasLayer/RichTextLabel.text = '[center]CATS: '+ str(cats_caught)
		current_cat.launch_cat()
		$CATCH.stream = load(meows[randi_range(0, 3)])
		$CATCH.play()
		spawn_text("CAUGHT!")
		new_cat()
		$PURR.play()
	else:
		print("REEL IN")
		print(current_cat.global_position)
		current_cat.health -= 1
		current_cat.reel_in()
		spawn_text("REEL IN!")
		$fishing_bar.rarity = 100 - current_cat.rarity - current_cat.health * 2

func spawn_text(msg):
	var text = text_effect.instantiate()
	text.position = Vector2(900, 400)
	text.text_set = msg
	add_child(text)

func new_cat():
	print("NEW CAT")
	var child = cats.instantiate()
	current_cat = child
	current_cat.global_position = $player.global_position + Vector2(165.0, 300.0)
	add_child(child)
	
	$fishing_bar.rarity = 100 - current_cat.rarity - current_cat.health * 2


func _on_start_pressed():
	$CATCH.play()
	current_cat.visible = true
	game_stopped = false
	$TITLE.visible = false
	$fishing_bar.visible = true
	$CanvasLayer.visible = true
	
