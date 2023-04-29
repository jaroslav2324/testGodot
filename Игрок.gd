extends Node2D

@export var adding_velocity = 100
@export var max_velocity = 220
@export var back_acceleration = 1

signal stroke_on_water

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Лодочник/StrokeComplete".hide()
	$"Лодочник/StrokeReady".hide()
	self.position.x = 200
	self.position.y = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("stroke"):
		increase_velocity()
		stroke_on_water.emit()
		# set timer for continuous movement(hold space)
		$StrokeTimer.start()
		$"Лодочник/StrokeTimerComplete".start()
		set_stroke_complete_texture()
		# $"Лодочник/StrokeAnimation".play("stroking")
		
	elif Input.is_action_just_released("stroke"):
		$StrokeTimer.stop()
		
	if $"Лодочник/StrokeTimerComplete".is_stopped() and $"Лодочник/StrokeTimerSitting".is_stopped():
		set_stroke_ready_texture()
		
	apply_back_acceleration()
	
		
		
func increase_velocity():
		var vel_x = self.linear_velocity.x + adding_velocity
		if vel_x > max_velocity:
			vel_x = max_velocity
		self.linear_velocity = Vector2(vel_x, 0)

# back acceleration
func apply_back_acceleration():
	if self.linear_velocity.x < 0:
		self.linear_velocity.x = 0
	elif self.linear_velocity.x > 0:
		self.linear_velocity.x -= back_acceleration


func _on_stroke_timer_timeout():
	$"Лодочник/StrokeTimerComplete".start()
	set_stroke_complete_texture()
	increase_velocity()
	stroke_on_water.emit()
	


func set_stroke_complete_texture():
	$"Лодочник/StrokeComplete".show()
	$"Лодочник/StrokeReady".hide()
	$"Лодочник/StrokeSitting".hide()
	
func set_stroke_ready_texture():
	$"Лодочник/StrokeReady".show()
	$"Лодочник/StrokeComplete".hide()
	$"Лодочник/StrokeSitting".hide()
	
func set_stroke_sitting_texture():
	$"Лодочник/StrokeSitting".show()
	$"Лодочник/StrokeReady".hide()
	$"Лодочник/StrokeComplete".hide()


func _on_stroke_timer_sitting_timeout():
	set_stroke_sitting_texture()
	
func _on_stroke_timer_complete_timeout():
	set_stroke_complete_texture()
