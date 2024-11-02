extends Node

# This script is not needed, the code must go inside the player script

@export var fishing_bar : PackedScene

var fishing = false
var cats = ["water_cat","salmon_cat","coral_cat"]
var bar


func spawn(p):
	bar = fishing_bar.instantiate()
	add_child(bar)
	bar.global_position = p
	fishing = true

func generate_Random_cat():
	return cats[randi_range(0,2)]

func _process(delta: float) -> void:
	if fishing:
		if Input.is_action_just_pressed("ui_accept"):
			var catched = bar.catch()
			if catched:
				print("you got a %s" % generate_Random_cat())
				bar.queue_free()
			else:
				print("Nope!")
				bar.queue_free()

func _ready() -> void:
	spawn($Marker2D.global_position)
