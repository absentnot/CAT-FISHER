extends RigidBody2D

@export var text_set = "CAUGHT!"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$RichTextLabel.text = "[center]"+text_set
	var random_impulse = Vector2(randf_range(-50.0, 50.0), randf_range(-20.0, -5.0))
	
	apply_impulse(random_impulse)
	var tw = create_tween()
	tw.tween_property($RichTextLabel, "scale", Vector2(1.25, 1.25), 0.15)
	tw.tween_property($RichTextLabel, "scale", Vector2(0.1, 0.1), 1.0)
	tw.tween_callback(queue_free)
