extends Node2D

@export var adding_velocity = 100
@export var max_velocity = 220
@export var back_acceleration = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.x = 200
	self.position.y = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("stroke"):
		increase_velocity()
		# set timer for continuous movement(hold space)
		$StrokeTimer.start()
		
	elif Input.is_action_just_released("stroke"):
		$StrokeTimer.stop()
		
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
