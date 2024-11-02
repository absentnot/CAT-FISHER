extends Node2D


@onready var area = $area
@onready var indicator = $Path2D/PathFollow2D/indicator
@onready var path = $Path2D/PathFollow2D

@export var rarity = 25

var cooldown = 10


func _process(delta: float) -> void:
	area.scale.x = rarity 
	if !cooldown <= 0:
		cooldown -= 0.1
		return
	move_indicator(delta)

func move_indicator(delta):
	if path.progress_ratio >= 1:
		return
	path.progress_ratio += 20/rarity* delta

func catch():
	var indicator_position = indicator.global_position
	var area_position = area.global_position
	var distance = area_position.distance_to(indicator_position)
	if distance <= rarity:
		return true
	else:
		return false
