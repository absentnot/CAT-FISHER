extends Node2D
signal caught_cat


@onready var area = $area
@onready var indicator = $Path2D/PathFollow2D/indicator
@onready var path = $Path2D/PathFollow2D

@export var rarity = 40

var cooldown = 10
var reverse = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var tw = create_tween()
		
		tw.tween_property(indicator, "scale", Vector2(23.0, 34.0)*1.25, 0.1)
		tw.tween_property(indicator, "scale", Vector2(18.0, 26.0), 0.1)
		tw.tween_property(indicator, "scale", Vector2(19.5, 28.12), 0.1)
		
		catch()
	area.scale.x = rarity 
	if !cooldown <= 0:
		cooldown -= 0.1
		return
	move_indicator(delta)
	

func move_indicator(delta):
	if path.progress_ratio > 0.99:
		#print("REVERSE")
		reverse = true
	if path.progress_ratio < 0.01:
		#print("UNREVERSE")
		reverse = false
	path.progress_ratio += (20.0/rarity* delta) * -1.0 if reverse else (20.0/rarity* delta) * 1.0

func catch():
	var indicator_position = indicator.global_position
	var area_position = area.global_position
	var distance = area_position.distance_to(indicator_position)
	if distance <= rarity:
		print("CAUGHT")
		emit_signal("caught_cat")
		return true
	else:
		print("FAILED")
		return false
