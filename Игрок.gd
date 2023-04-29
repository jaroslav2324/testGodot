extends Node2D

@export var adding_velocity = 100
@export var max_velocity = 220
@export var back_acceleration = 1

signal stroke_on_water

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Лодочник/StrokeComplete".hide()
	$"Лодочник/StrokeReady".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("stroke"):
		increase_velocity()
		stroke_on_water.emit()
		play_veslo_sound()
		# set timer for continuous movement(hold space)
		$StrokeTimer.start()
		set_stroke_complete_texture()
		$"Лодочник/StrokeTimerSitting".start()
		

	elif Input.is_action_just_released("stroke"):
		$StrokeTimer.stop()


		
	if $"Лодочник/StrokeTimerComplete".is_stopped() and $"Лодочник/StrokeTimerReady".is_stopped() and $"Лодочник/StrokeTimerSitting".is_stopped():
			set_stroke_sitting_texture()
		
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
	increase_velocity()
	stroke_on_water.emit()
	play_veslo_sound()
	
	
func play_veslo_sound():
	var p = randf()
	if p > 0.5:
		$veslo1player.play()
	else:
		$veslo2palyer.play()
	

func set_stroke_complete_texture():
	$"Лодочник/StrokeComplete".show()
	$"Лодочник/VesloComplete".show()
	$"Лодочник/StrokeReady".hide()
	$"Лодочник/VesloReady".hide()
	$"Лодочник/StrokeSitting".hide()
	$"Лодочник/VesloSitting".hide()
	
func set_stroke_ready_texture():
	$"Лодочник/StrokeReady".show()
	$"Лодочник/VesloReady".show()
	$"Лодочник/StrokeComplete".hide()
	$"Лодочник/VesloComplete".hide()
	$"Лодочник/StrokeSitting".hide()
	$"Лодочник/VesloSitting".hide()
	
func set_stroke_sitting_texture():
	$"Лодочник/StrokeSitting".show()
	$"Лодочник/VesloSitting".show()
	$"Лодочник/StrokeReady".hide()
	$"Лодочник/VesloReady".hide()
	$"Лодочник/StrokeComplete".hide()
	$"Лодочник/VesloComplete".hide()


func _on_stroke_timer_sitting_timeout():
	if not $StrokeTimer.is_stopped():
		$"Лодочник/StrokeTimerReady".start()
	set_stroke_sitting_texture()
	
func _on_stroke_timer_complete_timeout():
	if not $StrokeTimer.is_stopped():
		$"Лодочник/StrokeTimerSitting".start()
	set_stroke_complete_texture()

func _on_stroke_timer_ready_timeout():
	if not $StrokeTimer.is_stopped():
		$"Лодочник/StrokeTimerComplete".start()
	set_stroke_ready_texture()
