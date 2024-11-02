extends Node2D


@onready var area = $area
@onready var indicator = $Path2D/PathFollow2D/indicator
@onready var path = $Path2D/PathFollow2D

var rarity = 25


func _ready() -> void:
	area.scale.x = rarity

func _process(delta: float) -> void:
	move_indicator()

func move_indicator():
	if path.progress_ratio >= 1:
		return
	path.progress_ratio += .01

func catch():
	var indicator_position = indicator.global_position
	var area_position = area.global_position
	var distance = area_position.distance_to(indicator_position)
	if distance <= rarity:
		return true
	else:
		return false
